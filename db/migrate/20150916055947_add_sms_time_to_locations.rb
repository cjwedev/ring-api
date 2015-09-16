class AddSmsTimeToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :last_sms, :datetime
  end
end
