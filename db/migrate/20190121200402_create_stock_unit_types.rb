class CreateStockUnitTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_unit_types do |t|
      t.string :name
      t.jsonb :schema, null: false, default: []

      t.timestamps
    end
    add_index :stock_unit_types, :name, unique: true
  end
end
