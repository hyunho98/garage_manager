class CarsController < ApplicationController

  get '/cars/new' do
    not_logged_in?
    @user = current_user
    erb:'/cars/new'
  end

  get '/cars' do
    not_logged_in?
    @user = current_user
    @cars = @user.cars
    erb :'/cars/index'
  end

end
