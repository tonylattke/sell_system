class CreateCashTransactions < ActiveRecord::Migration
  def change
    create_table :cash_transactions do |t|
      t.string :type_t, default: 'deposit', null: false, :limit => 10
      t.text :description, null: false
      t.float :amount, default: 0, null: false

      t.timestamps
    end
  end
end
