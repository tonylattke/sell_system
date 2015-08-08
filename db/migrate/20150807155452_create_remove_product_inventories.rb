class CreateRemoveProductInventories < ActiveRecord::Migration
  def change
    create_table :remove_product_inventories do |t|
      t.references :product, index: true, null: false
      t.references :product_withdraw, index: true, null: false
      t.integer :amount, null: false, default: 1
    end
  end
end
