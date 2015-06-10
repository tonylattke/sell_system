class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :type_option, default: 'p', null: false, :limit => 2
      t.float :value, default: 1, null: false
      t.date :creation_date, default: Time.now, null: false
    end
  end
end
