require 'sinatra/base'
require 'sinatra/reloader'
require "sinatra/flash"
require_relative 'lib/result.rb'

class Application < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

    get '/' do
        return erb(:home)
    end

    post '/' do
        @selection = params[:selection]    
        @array = ["Rock", "Paper", "Scissors"]
        @computer = @array.sample
        @outcome = Result.new.checker(@selection, @computer)

        if @array.include?(@selection)
        return erb(:result)
        else
        flash[:notice] = 'Please select from Rock, Paper or Scissors'
        redirect "/"
        end
    end
end