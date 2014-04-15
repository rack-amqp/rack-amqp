require 'amqparty'
require 'benchmark'

AMQParty.configure do |c|
  c.amqp_host = 'localhost'
end

RUNS = 500
Benchmark.bm do |x|
  x.report('amqp') do
    RUNS.times do
      response = AMQParty.get('amqp://test.simple/users.json')
      raise unless response.code == 200
    end
  end
  x.report('http') do
    RUNS.times do
      response = HTTParty.get('http://localhost:8080/users.json')
      raise unless response.code == 200
    end
  end
end

# Last run on my mac against Userland:
#        user     system      total        real
# amqp  0.570000   0.060000   0.630000 (  3.036392)
# http  0.520000   0.120000   0.640000 (  4.091085)
