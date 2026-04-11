class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :sku, null: false
      t.string :name, null: false
      t.string :upc
      t.string :uom_base, default: 'EA', null: false
      
      # Booleans strictly default to false
      t.boolean :is_active, default: true, null: false
      t.boolean :is_kit, default: false, null: false
      t.boolean :is_batch, default: false, null: false
      t.boolean :is_serial, default: false, null: false
      t.boolean :is_hazard, default: false, null: false
      
      # Financials & Dimensions need precision
      t.decimal :cost, precision: 10, scale: 2, default: 0.0
      t.string :currency, default: 'USD'
      t.string :category
      t.string :storage
      t.string :coo
      t.string :hs_code
      
      t.decimal :uom_base_length, precision: 8, scale: 2
      t.decimal :uom_base_width, precision: 8, scale: 2
      t.decimal :uom_base_height, precision: 8, scale: 2
      t.decimal :uom_base_weight, precision: 8, scale: 2
      
      t.string :warehouse_code
      t.string :warehouse_name
      t.integer :customer_id
      t.string :account
      t.string :ringfence_tag
      t.string :location
      t.string :lp_number
      t.datetime :lp_creation_date

      t.timestamps
    end
    
    # Critical indices for the frontend search bar and filters
    add_index :inventories, :sku, unique: true
    add_index :inventories, :is_active
    add_index :inventories, :is_kit
  end
end