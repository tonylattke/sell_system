class ProductTag < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :tag, :class_name => 'Tag'

  validates :product, :uniqueness => {:scope => [:tag_id]}

  validates :product, :presence => true
  validates :tag, :presence => true

  def self.search(product,tag)
    if product
      where('product_id = ? and tag_id = ?', product, tag)
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
