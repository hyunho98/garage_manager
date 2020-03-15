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
    user = User.new(params)
    if user.save && user.name != "" && user.email != "" && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/index'
    else
      redirect '/signup'
    end
  end
end
