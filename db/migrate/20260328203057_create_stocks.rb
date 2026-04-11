class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.references :inventory, null: false, foreign_key: true
      t.integer :stock, default: 0, null: false
      t.integer :reserved, default: 0, null: false
      t.integer :available, default: 0, null: false

      t.timestamps
    end
    add_index :stocks, :available # For zero-stock / low-stock reports
  end
end

class CreateLicensePlates < ActiveRecord::Migration[7.1]
  def change
    create_table :license_plates do |t|
      t.references :inventory, null: false, foreign_key: true
      t.string :batch_number
      t.date :expiration
      t.integer :stock, default: 0, null: false
      t.integer :reserved, default: 0, null: false
      t.integer :available, default: 0, null: false
      t.string :tag
      t.string :location_path
      t.string :license_number

      t.timestamps
    end
    add_index :license_plates, :expiration # For expiry risk timeline
    add_index :license_plates, :batch_number
  end
end