class CreateProductTags < ActiveRecord::Migration
  def change
    create_table :product_tags do |t|
      t.references :product, index: true, null: false
      t.references :tag, index: true, null: false
    end
  end
end
