class CreateFulfillments < ActiveRecord::Migration[8.0]
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
