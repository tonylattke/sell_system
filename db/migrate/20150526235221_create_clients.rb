class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :dni, null: false
      t.string :name, null: false
      t.date :subscription_date, null: false, default: Time.now
      t.float :balance, null: false, default: 0
    end
    # Unique DNI Client
    add_index :clients, :dni, unique: true
  end
end
