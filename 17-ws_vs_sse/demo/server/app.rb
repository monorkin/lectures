# frozen_string_literal: true

class App < Roda
  QUEUES = []

  plugin :streaming
  plugin :render, engine: 'slim'

  route do |r|
    r.root do
      view('root', layout: false)
    end

    r.on 'messages' do
      r.post do
        name = r.params['name']
        message = r.params['message']
        object = { name: name, message: message }
        QUEUES.each { |q| q << object }
        object.to_json
      end
    end

    r.get 'stream' do
      response['Content-Type'] = 'text/event-stream;charset=UTF-8'
      q = Queue.new
      QUEUES << q
      stream(loop: true, callback: proc { QUEUES.delete(q) }) do |out|
        loop do
          out << "data: #{q.pop.to_json}\n\n"
        end
      end
    end
  end
end
