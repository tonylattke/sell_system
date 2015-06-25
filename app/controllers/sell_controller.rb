class SellController < ApplicationController
  def index
  end

  def search_products_by_tag
    @products = []
    tags = Tag.search(params[:data])
    for tag in tags
      product_tags = ProductTag.search_by('tag_id',tag.id)
      for product_tag in product_tags
        product = Product.find_by(id: product_tag.product_id)
        @products.push(product)
      end
    end
  end
  
end