class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.under_hundred_days_to_harvest_plants
  end
end