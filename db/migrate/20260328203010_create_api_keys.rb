class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :token, null: false
      t.string :name, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
    add_index :api_keys, :token, unique: true
  end
end