require 'benchmark'
require 'httparty'
require 'rack/amqp/curl'
require 'rack/amqp/client'


n = 5_000

Benchmark.bm do |bm|

  bm.report("HTTP:") do
    n.times do
      HTTParty.get("http://localhost:9292/users.json")
    end
  end
  bm.report("AMQP") do
    Rack::AMQP::Client.with_client(host: 'localhost') do |client|
      n.times do
        client.request('test.simple/users.json', {http_method: 'GET'})
      end
    end
  end
end
