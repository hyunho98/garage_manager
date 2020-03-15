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
        session[:error] = "You are not logged in!"
        redirect '/'
      end
    end

  end

end
