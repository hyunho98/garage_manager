class CarsController < ApplicationController

  get '/cars/new' do
    not_logged_in?
    @user = current_user
    @types = car_types
    erb:'/cars/new'
  end

  get '/cars' do
    not_logged_in?
    @user = current_user
    @cars = @user.cars
    erb :'/cars/index'
  end

  get '/cars/:id' do
    not_logged_in?
    @car = Car.find(params[:id])
    belong_here?(@car.user.id)
    @garage = Garage.find(@car.garage_id)
    erb :'/cars/show'
  end

  get '/cars/:id/edit' do
    not_logged_in?
    @car = Car.find(params[:id])
    belong_here?(@car.user_id)
    @garage = Garage.find(@car.garage_id)
    @garages = current_user.garages
    @types = car_types
    erb :'/cars/edit'
  end

end
