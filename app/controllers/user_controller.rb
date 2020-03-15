class UsersController < ApplicationController

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/index'
    else
      redirect '/'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save && user.username != "" && user.email != "" && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/index'
    else
      redirect '/signup'
    end
  end

  get '/index' do
    not_logged_in?
      @user = current_user
      erb :index
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
