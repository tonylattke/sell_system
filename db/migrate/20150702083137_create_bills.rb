class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :client, index: true, null: false

      t.timestamps
    end
  end
end
