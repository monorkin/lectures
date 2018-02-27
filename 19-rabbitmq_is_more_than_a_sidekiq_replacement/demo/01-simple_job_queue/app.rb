# frozen_string_literal: true

require 'roda'
require_relative 'chat'

class App < Roda
  JOBS = Queue.new
  Thread.new do
    loop do
      begin
        JOBS.pop.call
      rescue
        puts 'Ups!'
      end
    end
  end

  Chat.start_heartbeat

  plugin :streaming
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      view('root', layout: false)
    end

    r.get 'stream' do
      response['Content-Type'] = 'text/event-stream;charset=UTF-8'
      user_queue = Chat.subscribe
      callback = proc { Chat.unsubscribe(user_queue) }
      stream(loop: true, callback: callback) do |out|
        Chat.stream(out, user_queue)
      end
    end

    r.on 'messages' do
      r.post do
        name = r.params['name']
        message = r.params['message']
        if message.match?(%r{^\\broadcast\s+.*$})
          message = message.scan(%r{^\\broadcast\s+(.*)$}).flatten.first
          JOBS << proc do
            Chat.broadcast(message)
          end
        else
          Chat.message(name, message)
        end
      end
    end
  end
end
