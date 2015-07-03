class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :client, index: true

      t.timestamps
    end
  end
end
