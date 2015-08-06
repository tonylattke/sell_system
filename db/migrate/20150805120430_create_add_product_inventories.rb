class CreateAddProductInventories < ActiveRecord::Migration
  def change
    create_table :add_product_inventories do |t|
      t.references :product, index: true, null: false
      t.references :bill_provider, index: true, null: false
      t.integer :amount, null: false, default: 1
    end
  end
end
