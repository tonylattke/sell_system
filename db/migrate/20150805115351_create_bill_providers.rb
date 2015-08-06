class CreateBillProviders < ActiveRecord::Migration
  def change
    create_table :bill_providers do |t|
      t.string :number
      t.float :price
      t.references :provider, index: true

      t.timestamps
    end
  end
end
