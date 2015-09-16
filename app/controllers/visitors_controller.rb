class VisitorsController < ApplicationController
  def map
    @location = Location.where("device_id = ?", params[:device_id]).try(:first)
  end

  def location_updated
  	@location = Location.where("device_id = ?", params[:device_id]).try(:first)

  	render(json: @location.to_json, status: :created) and return
  end

  def index
  end
end