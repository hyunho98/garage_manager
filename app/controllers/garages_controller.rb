class GaragesController < ApplicationController
  get '/garages' do
    not_logged_in?
    @user = current_user
    @garages = @user.garages
    erb :'garages/index'
  end
end
