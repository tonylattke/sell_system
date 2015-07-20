class CreateSaleTransactions < ActiveRecord::Migration
  def change
    create_table :sale_transactions do |t|
      t.string :type_t, default: 'cash', null: false, :limit => 10
      t.float :amount, default: 0, null: false
      t.references :bill, index: true
    end
  end
end
