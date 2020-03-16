class CarsController < ApplicationController

  get '/cars/new' do
    not_logged_in?
    @user = current_user
    @types = car_types
    @garages = @user.garages
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

  post '/cars' do
    not_logged_in?
    if !params[:year].empty? && !params[:make].empty? && !params[:model].empty? && !params[:type].empty? && !params[:license_plate].empty? && !params[:price].empty?
      car = Car.new(year: params[:year].to_i, make: params[:make], model: params[:model], type: params[:type], license_plate: params[:license_plate], price: params[:price].to_f, garage_id: params[:garage_id])
      if car.save
        current_user.cars << car
        current_user.garages.cars << car
        redirect "/cars/#{car.id}"
      else
        redirect "/cars/new"
      end
    end
  end

  patch '/cars/:id' do
    not_logged_in?
    if !params.keys.include?("garage_id")
      params[:garage_id] = nil
    end

    @car = Car.find(params[:id])
    @car.update(params)
    redirect "/cars/#{@car.id}"
  end

  delete '/cars/:id' do
    not_logged_in?
    @car = car.find(params[:id])
    if @car
      @car.destroy
      redirect '/cars'
    end
  end

end
