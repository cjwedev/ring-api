class VisitorsController < ApplicationController
  def map
    @location = Location.find_by_device_id(params[:device_id])
    puts "*" * 10
    puts "#{location.longitude}"
    puts "*" * 10
    puts "#{location.latitude}"
  end

  def index
  end
end