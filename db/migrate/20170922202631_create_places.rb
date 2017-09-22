class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :price
      t.string :transaction_type
      t.decimal :surface
      t.string :address

      t.timestamps
    end
  end
end
