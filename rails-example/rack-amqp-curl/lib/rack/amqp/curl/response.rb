module Rack
  module AMQP
    module Curl
      class Response

        attr_accessor :meta, :payload
        def initialize(meta, payload)
          @meta = meta
          @payload = payload
        end

      end
    end
  end
end

