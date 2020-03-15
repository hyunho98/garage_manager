class GaragesController < ApplicationController

  get '/garages/new' do
    not_logged_in?
    @user = current_user
    erb:'/garages/new'
  end

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

  post '/garages' do
    not_logged_in?
    if !params[:name].empty? && !params[:address].empty? && !params[:capacity].empty?
      garage = Garage.new(name: params[:name], address: params[:address], capacity: params[:capacity])
      if garage.save
        current_user.garages << garage
        redirect "/garages/#{garage.id}"
      else
        redirect "/garages/new"
      end
    end
  end

end
