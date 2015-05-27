class Client < ActiveRecord::Base
  validates :dni, :presence => true, :length => { :minimum => 1 }
  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :subscription_date, :presence => true
  validates :balance, :presence => true
end
