class AddMissingFieldsToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :ges, :decimal
    add_column :places, :energy_class, :decimal
    add_column :places, :description, :text
  end
end
