require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_secret"
  end

  get "/" do
    if logged_in?
      redirect '/index'
    else
      erb :welcome
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def not_logged_in?
      if !logged_in?
        redirect '/'
      end
    end

    def belong_here?(id)
      if current_user.id != id
        redirect '/index'
      end
    end

    def car_types
      ["SUV", "Truck", "Sedan", "Coupe", "Wagon", "Crossover"]
    end

  end

end
