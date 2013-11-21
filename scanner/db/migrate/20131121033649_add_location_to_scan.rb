class AddLocationToScan < ActiveRecord::Migration
  def change
    add_column :scans, :latitude, :string
    add_column :scans, :longitude, :string
  end
end
