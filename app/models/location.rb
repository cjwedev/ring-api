class Location < ActiveRecord::Base
  validates :device_id, :longitude, :latitude, presence: true
end