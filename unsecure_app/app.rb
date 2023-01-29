require 'sinatra/base'
require "sinatra/reloader"
require "sinatra/flash"

class Application < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = params[:name]
    if @name.match?(/[^a-z]/i)
      flash[:notice] = 'Please ensure your name is the a-z characters only.'
      redirect "/"
    else
      return erb(:hello)  
    end 
  end
end
