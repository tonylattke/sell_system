class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :stock_amount, default: 0, null: false
      t.integer :sales_amount, default: 0, null: false
      t.attachment :photo
    end
    # Unique Name
    add_index :products, :name, unique: true
  end
end