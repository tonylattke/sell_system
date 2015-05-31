class Product < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 1 }
  validates :stock_amount, :presence => true
  validates :sales_amount, :presence => true

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
