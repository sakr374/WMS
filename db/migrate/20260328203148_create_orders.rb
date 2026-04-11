class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :order_number
      t.string :order_type, null: false # 'inbound' or 'outbound'
      t.string :order_status, null: false
      t.date :date_1
      t.integer :lines_count, default: 0, null: false
      t.string :delivery_type
      t.integer :carrier_id
      t.string :tracking
      t.text :instruction
      t.integer :warehouse_id
      t.integer :customer_id
      t.jsonb :shipping_address, default: {} # Secure NoSQL structure in PG

      t.timestamps
    end
    add_index :orders, :order_type
    add_index :orders, :order_status
    add_index :orders, :created_at # For order volume charts
  end
end

class CreateOrderLines < ActiveRecord::Migration[7.1]
  def change
    create_table :order_lines do |t|
      t.references :order, null: false, foreign_key: true
      t.references :inventory, foreign_key: true # Nullable, in case SKU isn't in DB yet
      t.string :sku, null: false
      t.string :uom, default: 'EA'
      t.integer :planned, default: 0, null: false
      t.integer :completed, default: 0, null: false
      t.string :lot_control
      t.date :expiration
      t.string :ringfence_tag

      t.timestamps
    end
  end
end

class CreateFulfillments < ActiveRecord::Migration[7.1]
  def change
    create_table :fulfillments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :fulfillment_status
      t.string :primary_tracking
      t.string :primary_tracking_company

      t.timestamps
    end
  end
end