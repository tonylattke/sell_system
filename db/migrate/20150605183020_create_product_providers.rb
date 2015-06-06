class CreateProductProviders < ActiveRecord::Migration
  def change
    create_table :product_providers do |t|
      t.references :product, index: true
      t.references :provider, index: true
    end
  end
end
