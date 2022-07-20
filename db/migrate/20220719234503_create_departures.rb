class CreateDepartures < ActiveRecord::Migration[7.0]
  def change
    create_table :departures do |t|
      t.date :date
      t.decimal :price, precision: 8, scale: 2, null:false, default: 0.0
      t.timestamps
    end
  end
end
