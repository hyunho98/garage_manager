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
    if Garage.exists?(params[:id])
      @garage = Garage.find_by(id: params[:id])
      belong_here?(@garage.user_id)
      @cars = @garage.cars
      @full = ((@garage.capacity - @cars.length) <= 0)
      erb :'/garages/show'
    else
      redirect "/garages"
    end
  end

  get '/garages/:id/edit' do
    not_logged_in?
    if Garage.exists?(params[:id])
      @garage = Garage.find_by(id: params[:id])
      belong_here?(@garage.user_id)
      @cars = @garage.cars
      @garageless = []
      current_user.cars.each {|car| !car.garage ? @garageless << car : nil}
      erb :'/garages/edit'
    else
      redirect "/garages"
    end
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

  patch '/garages/:id' do
    not_logged_in?
    if !params[:garage].keys.include?("car_ids")
      params[:garage][:car_ids] = []
    end

    garage = Garage.find(params[:id])

    if params[:garage][:car_ids].length > params[:garage][:capacity].to_i
      redirect "/garages/#{params[:id]}/edit"
    else
      garage.cars.each do |car|
        if !params[:garage][:car_ids].include?(car.id)
          garage.cars.delete(car.id)
        end
      end
      garage.update(params[:garage])
      redirect "/garages/#{garage.id}"
    end
  end

  delete '/garages/:id' do
    not_logged_in?
    @garage = Garage.find(params[:id])
    @garage.cars = []
    if @garage
      @garage.destroy
      redirect '/garages'
    end
  end

end
