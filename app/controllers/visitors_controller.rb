class VisitorsController < ApplicationController
  def map
    @location = Location.find_by_device_id(params[:device_id])
  end

  def index
  end
end