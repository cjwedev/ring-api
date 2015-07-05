class VisitorsController < ApplicationController
  def map
    @location = Location.where("device_id = ?", params[:device_id]).try(:first)
  end

  def index
  end
end