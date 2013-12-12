module Rack
  module AMQP
    module Curl
      class Client

        attr_accessor :connection_options, :amqp_channel, :amqp_client

        def initialize(broker_connection_options)
          connect!(broker_connection_options)
          @correlation_id = 0
        end

        def request(uri, options={})
          http_method = options[:http_method]
          timeout = options[:timeout] || 5


          request = Request.new(@correlation_id += 1, http_method, uri, "", headers: {})
          callback_queue = create_callback_queue(request.callback)
          request.callback_queue = callback_queue

          amqp_channel.direct('').publish(request.payload, request.publishing_options)

          response = request.reply_wait(timeout)
          response
        end

        private

        def create_callback_queue(cb)
          # build queue
          queue = build_callback_queue(cb)
          # bind to an exchange, maybe later
          queue
        end

        def build_callback_queue(cb)
          ::AMQP::Queue.new(amqp_channel, "", auto_delete: true, exclusive: true, &sync_cb(Fiber.current))
          queue, declare_ok = Fiber.yield

          Fiber.new do
            queue.subscribe &sync_cb(Fiber.current)
            loop { cb.call(Fiber.yield) }
          end.resume
          queue
        end

        def connect!(broker_options)
          @amqp_client = sync do |f|
            ::AMQP.connect(broker_options, &sync_cb(f))
          end
          # TODO Handle errors nicely
          @amqp_channel = ::AMQP::Channel.new(@amqp_client)
        end

        def sync &block
          fiber = Fiber.current
          block.call(fiber)
          Fiber.yield
        end

        def sync_cb fiber
          ->(*args){
            if fiber == Fiber.current
              return *args
            else
              fiber.resume(*args)
            end
          }
        end

      end
    end
  end
end
