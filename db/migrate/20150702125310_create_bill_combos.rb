class CreateBillCombos < ActiveRecord::Migration
  def change
    create_table :bill_combos do |t|
      t.references :bill, index: true, null: false
      t.integer :amount, null: false, default: 1
      t.references :price, index: true, null: false
    end
  end
end
