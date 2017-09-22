class ChangeLatLongTypeToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :places, :latitude,  :float
    change_column :places, :longitude, :float
  end
end
