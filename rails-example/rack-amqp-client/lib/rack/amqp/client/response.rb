module Rack
  module AMQP
    module Client
      class Response

        attr_accessor :meta, :payload
        def initialize(meta, payload)
          @meta = meta
          @payload = payload
        end

        def headers
          meta[:headers]
        end

        def response_code
          headers['X-AMQP-HTTP-Status']
        end
      end
    end
  end
end

