class BillArticle < ActiveRecord::Base
  belongs_to :bill, :class_name => 'Bill'
  belongs_to :price, :class_name => 'Price'

  validates :bill, :uniqueness => {:scope => [:price_id]}

  validates :bill, :presence => true
  validates :price, :presence => true
  validates :amount, :presence => true
end
