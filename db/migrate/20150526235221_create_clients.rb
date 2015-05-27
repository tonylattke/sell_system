class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :dni
      t.string :name
      t.date :subscription_date
      t.float :balance
    end
  end
end
