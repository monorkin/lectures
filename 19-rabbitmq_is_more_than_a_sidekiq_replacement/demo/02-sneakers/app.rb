# frozen_string_literal: true

require 'roda'
require 'uri'
require 'json'
require 'logger'
require 'net/http'
require_relative 'chat'

Sneakers.logger = Logger.new(STDOUT)

class Scraper
  include Sneakers::Worker
  from_queue :scraper

  def work(title)
    params = '/?' + URI.encode_www_form([[:t, title], [:apikey, 'PlsBanMe']])
    response = Net::HTTP.get_response('omdbapi.com', params)
    movie = JSON.parse(response.body) rescue nil

    return reject! unless movie

    if movie['Response'] == 'False'
      Chat.http_broadcast("Can't show movie '#{title}' - #{movie['Error']}")
      return ack!
    end

    message = "#{movie['Title']} "\
              "(#{movie['Year']}) - "\
              "#{movie['Director']} | #{movie['Genre']}"

    Chat.http_broadcast(message)

    ack!
  end
end

class App < Roda
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
        if message.match?(/^\\movie\s+.*$/)
          title = message.scan(/^\\movie\s+(.*)$/).flatten.first
          Scraper.enqueue(title)
          { movie: title }.to_json
        elsif message.match?(/^\\broadcast\s+.*$/)
          message = message.scan(/^\\broadcast\s+(.*)$/).flatten.first
          Chat.broadcast(message)
        else
          Chat.message(name, message)
        end
      end
    end
  end
end
