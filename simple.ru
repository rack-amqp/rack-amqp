require 'sinatra'
set :env, :production
disable :run
require './simple.rb'
run Sinatra::Application
