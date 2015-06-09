class CreateComboProducts < ActiveRecord::Migration
  def change
    create_table :combo_products do |t|
      t.references :product, index: true, null: false
      t.references :combo, index: true, null: false
      t.integer :product_amount, default: 1, null: false
    end
  end
end
