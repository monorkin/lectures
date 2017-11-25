# frozen_string_literal: true

class App < Roda
  QUEUE = Queue.new

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
        ::App::QUEUE << object
        object.to_json
      end
    end

    r.get 'stream' do
      response['Content-Type'] = 'text/event-stream;charset=UTF-8'

      stream(loop: true) do |out|
        out << "data: #{::App::QUEUE.pop.to_json}\n\n"
      end
    end
  end
end
