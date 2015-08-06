class AddProductInventory < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :bill_provider, :class_name => 'BillProvider'

  validates :product, :uniqueness => {:scope => [:bill_provider_id]}

  validates :product, :presence => true
  validates :bill_provider, :presence => true
  validates :amount, :presence => true
end
