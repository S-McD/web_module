require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/hello' do
    # name = params[:name]
    # p "Hello #{name}"

    return erb(:index)
  end

  get '/names' do
    message = params[:message]
    return message
    
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
  
    return "Thanks #{name}, you sent this message: #{message}"
  end

  post '/sort-names' do
    message = params[:message]
    return message.split(",").sort.join(",")
  end
end