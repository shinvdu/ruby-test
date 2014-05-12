require 'sinatra'
use Rack::Auth::Basic do |username, password|
      username == 'admin' && password == 'secret'
end
set :public_folder, File.dirname(__FILE__) + '/public_folder'
set :views, File.dirname(__FILE__) + '/views'

get '/' do
    @xie = request
    erb :index
end
