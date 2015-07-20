class SaleTransaction < ActiveRecord::Base
  belongs_to :bill, :class_name => 'Bill'

  validates :amount, :presence => true
  validates :bill, :presence => true
  validates :type_t, :presence => true

  default_scope { order('bill_id DESC') }  
end
