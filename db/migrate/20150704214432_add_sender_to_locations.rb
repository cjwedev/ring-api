class AddSenderToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :sender, :string
  end
end
