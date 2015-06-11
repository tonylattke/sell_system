class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :type_option, default: 'p', null: false, :limit => 2
      t.float :value, default: 1, null: false
      t.references :product, index: true
      t.references :combo, index: true

      t.timestamps
    end
  end
end
