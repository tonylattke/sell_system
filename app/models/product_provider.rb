class ProductProvider < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :provider, :class_name => 'Provider'

  validates :product, :uniqueness => {:scope => [:provider_id]}

  validates :product, :presence => true
  validates :provider, :presence => true

  def self.search(product,provider)
    if product
      where('product_id = ? and provider_id = ?', product, provider)
    else
      scoped
    end
  end

  def self.search_by(type,data)
    if data
      where(type + ' = ?', data)
    else
      scoped
    end
  end
end
