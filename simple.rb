require 'sinatra'

get '/' do
  "Hello, #{params.inspect}"
end
