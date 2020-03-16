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
    @cars = current_user.cars
    erb :'/cars/index'
  end

  get '/cars/:id' do
    not_logged_in?
    @car = Car.find(params[:id])
    belong_here?(@car.user.id)
    @garage = Garage.find_by(id: @car.garage_id)
    erb :'/cars/show'
  end

  get '/cars/:id/edit' do
    not_logged_in?
    @car = Car.find(params[:id])
    belong_here?(@car.user_id)
    @garage = Garage.find_by(id: @car.garage_id)
    @garages = current_user.garages
    @types = car_types
    erb :'/cars/edit'
  end

  post '/cars' do
    not_logged_in?
    if !params[:year].empty? && !params[:make].empty? && !params[:model].empty? && !params[:car_type].empty? && !params[:license_plate].empty? && !params[:price].empty?
      car = Car.new(year: params[:year].to_i, make: params[:make], model: params[:model], car_type: params[:car_type], license_plate: params[:license_plate], price: params[:price].to_f, garage_id: params[:garage_id])
      if car.save
        if params[:garage_id]
          garage = Garage.find(params[:garage_id])
          garage.cars << car
        end
        current_user.cars << car
        redirect "/cars/#{car.id}"
      else
        redirect "/cars/new"
      end
    end
  end

  patch '/cars/:id' do
    not_logged_in?

    @car = Car.find(params[:id])

    if params[:car][:garage_id] == "no_garage"
      garage = Garage.find(@car.garage_id)
      garage.delete(@car.id)
      params[:car][:garage_id].clear
    end

    @car.update(params[:car])
    redirect "/cars/#{@car.id}"
  end

  delete '/cars/:id' do
    not_logged_in?
    @car = Car.find(params[:id])
    if @car
      @car.destroy
      redirect '/cars'
    end
  end

end
