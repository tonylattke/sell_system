class DeleteStockAmountCombo < ActiveRecord::Migration
  def change
    remove_column :combos, :stock_amount
  end
end
