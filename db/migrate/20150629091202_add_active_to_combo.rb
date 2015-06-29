class AddActiveToCombo < ActiveRecord::Migration
  def change
    add_column :combos, :active, :boolean, :default => true
  end
end
