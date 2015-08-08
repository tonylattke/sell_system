class ProductsWithdraw < ActiveRecord::Base
	#has_many :remove_product_inventories

	default_scope { order('created_at DESC') }
end
