class ComboProduct < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :combo, :class_name => 'Combo'

  validates :product, :uniqueness => {:scope => [:combo_id]}

  validates :product, :presence => true
  validates :combo, :presence => true

  def self.search(combo,product)
    if combo
      where('combo_id = ? and product_id = ?', combo, product)
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
