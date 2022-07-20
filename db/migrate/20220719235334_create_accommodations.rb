class CreateAccommodations < ActiveRecord::Migration[7.0]
  def change
    create_table :accommodations do |t|
      t.string  :name, null: false, default: ""
      t.string  :location, null: false, default: ""
      t.decimal :price, precision: 8, scale: 2,  null: false, default: 0.0
      t.references :start, foreign_key: { to_table: :departures }
      t.references :end, foreign_key: { to_table: :departures }
      t.timestamps
    end
  end
end
