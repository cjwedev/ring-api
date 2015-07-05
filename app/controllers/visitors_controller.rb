class VisitorsController < ApplicationController
  def map
    @location = Location.where("device_id = ?", params[:device_id]).try(:first)
    puts "*" * 10
    puts "#{location.longitude}"
    puts "*" * 10
    puts "#{location.latitude}"
  end

  def index
  end
end