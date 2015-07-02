class BillCombo < ActiveRecord::Base
  belongs_to :bill
  belongs_to :price

  validates :bill, :presence => true
  validates :price, :presence => true
  validates :amount, :presence => true
end
