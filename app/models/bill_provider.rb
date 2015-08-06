class BillProvider < ActiveRecord::Base
  belongs_to :provider, :class_name => 'Provider'
  has_many :add_product_inventories

  validates :provider, :presence => true

  default_scope { order('created_at DESC') }
end