require 'rack'
require 'amqp'
require 'rack/content_length'
require 'rack/rewindable_input'

raw = File.read(ARGV[0])
app = eval("Rack::Builder.new {( #{raw} )}.to_app")
racked_app = Rack::Builder.new do
  use Rack::ContentLength
  use Rack::Chunked
  use Rack::CommonLogger, $stderr
  use Rack::Lint
  run app
end.to_app

def handle_request(app, uri)
  parts = uri.split(/\?/)
  uri = parts[0]
  query = parts[1] || ""
  env = ENV.to_hash
  env.update({
    "rack.version" => Rack::VERSION,
    "rack.input" => Rack::RewindableInput.new($stdin),
    "rack.errors" => $stderr,

    "rack.multithread" => false,
    "rack.multiprocess" => true,
    "rack.run_once" => true,

    "rack.url_scheme" => ["yes", "on", "1"].include?(ENV["HTTPS"]) ? "https" : "http",

    'REQUEST_METHOD' => 'GET',
    'SERVER_NAME' => 'howdy',
    'SERVER_PORT' => '8080',
    'PATH_INFO' => uri,
    'QUERY_STRING' => query,
    'HTTP_VERSION' => '1.1',
    'REQUEST_PATH' => uri,
  })
  response_code, headers, body = app.call(env)
  response = []
  response << "Response code: #{response_code}"
  response << "Headers: #{headers.inspect}"
  response << "Body Follows:"
  body.each{|chunk| response << chunk }
  body.close
  response.join("\n")
end

AMQP.start(host: 'localhost') do |client, open_ok|
  chan  = AMQP::Channel.new(client)

  chan.queue("test.simple", auto_delete: true).subscribe do |payload|
    puts "Received message: #{payload.inspect}"
    response = handle_request racked_app, payload
    chan.direct("").publish(response, routing_key: "test.simple.reply")
  end

  puts "go go go"
end
