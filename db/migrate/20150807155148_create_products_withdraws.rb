class CreateProductsWithdraws < ActiveRecord::Migration
  def change
    create_table :products_withdraws do |t|
      t.timestamps
    end
  end
end
