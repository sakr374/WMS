class CreateOrderLines < ActiveRecord::Migration[8.0]
  def change
    create_table :order_lines do |t|
      t.references :order, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      t.string :sku
      t.string :uom
      t.integer :planned
      t.integer :completed
      t.string :lot_control
      t.date :expiration
      t.string :ringfence_tag

      t.timestamps
    end
  end
end
