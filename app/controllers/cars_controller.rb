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
    @cars = @garage.cars
    @garageless = Car.all.collect {|car| car.garage == nil}
    erb :'/garages/edit'
  end

end
