class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.string :name, null: false
      t.integer :stock_amount, default: 0, null: false
      t.integer :sales_amount, default: 0, null: false
      t.attachment :photo
    end
    # Unique Name
    add_index :combos, :name, unique: true
  end
end