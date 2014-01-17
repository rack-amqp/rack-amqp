require 'net/http'
require 'httparty'
require 'amqparty/version'
require 'amqparty/request'


module AMQParty

  SUPPORTED_HTTP_METHODS = %w{get post put delete head options}
  SUPPORTED_HTTP_METHODS.each do |method|
    class_eval <<-EOT
      def self.#{method}(path, options={}, &block)
        perform_request Net::HTTP::#{method.to_s[0...1].upcase}#{method.to_s[1..-1]}, path, options, &block
      end
    EOT
  end

  private

    def self.perform_request(http_method, path, options, &block)
      options = default_options.dup.merge(options)
      # TODO cookies support
      Request.new(http_method, "amqp://#{path}", options).perform(&block)
    end

    def self.default_options
      {}
    end
end
