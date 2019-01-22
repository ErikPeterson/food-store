class CreateStockUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_units do |t|
      t.integer :owner_id, null: false
      t.integer :stock_unit_type_id, null: false
      t.text :description, null: false, default: ''
      t.integer :mass_in_grams, null: false
      t.date :expiration_date, null: false
      t.jsonb :unit_attributes, null: false

      t.timestamps
    end
  end
end
