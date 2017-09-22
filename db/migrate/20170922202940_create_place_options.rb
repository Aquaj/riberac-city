class CreatePlaceOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :place_options do |t|
      t.references :place, foreign_key: true
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
