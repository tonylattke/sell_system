class Price < ActiveRecord::Base
  belongs_to :product, :class_name => 'Product'
  belongs_to :combo, :class_name => 'Combo'

  validates :value, :presence => true
  validates :type_option, :presence => true
  
  def to_s
    return "#{@type_option} #{@value}"
  end

  default_scope { order('created_at DESC') }  
end
