require 'sinatra'

set :env,       :production
set :port,      4567
disable :run, :reload

require './application.rb'

run Sinatra::Application
