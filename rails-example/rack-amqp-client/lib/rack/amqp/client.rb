require 'fiber'
require 'amqp'
require "rack/amqp/client/request"
require "rack/amqp/client/response"
require "rack/amqp/client/manager"
require "rack/amqp/client/version"

module Rack
  module AMQP
    module Client
      def self.with_client(*args, &block)
        EM.run do
          Fiber.new {
            yield Manager.new(*args)
            EM.stop
          }.resume
        end
      end

    end
  end
end
