# frozen_string_literal: true

class Chat
  class << self
    def queues
      @queues ||= []
    end

    def subscribe
      user_queue = Queue.new
      queues << user_queue
      heartbeat(user_queue)
    end

    def unsubscribe(user_queue)
      queues.delete(user_queue)
    end

    def stream(out, user_queue)
      loop do
        out << "data: #{user_queue.pop.to_json}\n\n"
      end
    end

    def message(name, body)
      object = { name: name, message: body }
      queues.each { |q| q << object }
      object.to_json
    end

    def broadcast(message)
      object = { broadcast: true, message: message }
      queues.each { |q| q << object }
      object.to_json
    end

    def heartbeat(user_queue)
      user_queue << { heartbeat: true }
    end

    def broadcast_heartbeat
      queues.each do |user_queue|
        heartbeat(user_queue)
      end
    end

    def start_heartbeat
      Thread.new do
        loop do
          sleep(30)
          bradcast_heartbeat
        end
      end
    end
  end
end
