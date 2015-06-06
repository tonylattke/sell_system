class ProductProvider < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :provider, :class_name => 'Provider'

  def self.search(product,provider)
    if product
      where('product_id = ? and provider_id = ?', product, provider)
    else
      scoped
    end
  end
end
