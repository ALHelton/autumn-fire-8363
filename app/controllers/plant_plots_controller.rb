class PlantPlotsController < ApplicationController
  def destroy
    @plantplot = PlantPlot.find_by(plot_id: params[:plot_id], plant_id: params[:plant_id])
    @plantplot.destroy
    redirect_to "/plots"
  end
end