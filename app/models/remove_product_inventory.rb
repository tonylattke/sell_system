class RemoveProductInventory < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :product_withdraw, :class_name => 'ProductsWithdraw'

  validates :product, :uniqueness => {:scope => [:product_withdraw_id]}

  validates :product, :presence => true
  validates :product_withdraw, :presence => true
  validates :amount, :presence => true
end
