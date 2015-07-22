class CashTransaction < ActiveRecord::Base

  validates :description, :presence => true
  validates :amount, :presence => true
  validates :type_t, :presence => true

  default_scope { order('created_at DESC') }
end
