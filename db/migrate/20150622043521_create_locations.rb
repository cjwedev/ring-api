class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :device_id
      t.float :longitude
      t.float :latitude
      t.string :message
      t.string :contacts

      t.timestamps
    end
  end
end
