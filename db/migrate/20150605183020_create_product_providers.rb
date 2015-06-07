class CreateProductProviders < ActiveRecord::Migration
  def change
    create_table :product_providers do |t|
      t.references :product, index: true, null: false
      t.references :provider, index: true, null: false
    end
  end
end
