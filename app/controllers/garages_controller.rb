class GaragesController < ApplicationController

  get '/garages' do
    not_logged_in?
    @user = current_user
    @garages = @user.garages
    erb :'/garages/index'
  end

  get '/garages/:id' do
    not_logged_in?
    @garage = Garage.find_by(id: params[:id])
    @cars = @garage.cars
    @full = ((@garage.capacity - @cars.length) <= 0)
    erb :'/garages/show'
  end

  get '/garages/new' do
    not_logged_in?
    @user = current_user
    erb:'/garages/new'
  end
end
