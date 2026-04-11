class CreateLicensePlates < ActiveRecord::Migration[8.0]
  def change
    create_table :license_plates do |t|
      t.references :inventory, null: false, foreign_key: true
      t.string :batch_number
      t.date :expiration
      t.integer :stock
      t.integer :reserved
      t.integer :available
      t.string :tag
      t.string :location_path
      t.string :license_number

      t.timestamps
    end
  end
end
