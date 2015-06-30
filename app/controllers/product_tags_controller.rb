class ProductTagsController < ApplicationController
  before_action :set_product_tag

  respond_to :json


  # GET /product_tags
  def index
    @product_tags = ProductTag.all
    respond_with @product_tags
  end

  # GET /product_tags/:id
  def show
    respond_with @product_tag
  end

  # GET /product_tags/search/:product_id/:tag_id
  def search
    @product_tags = nil
    product_tags = ProductTag.search(params[:product_id],params[:tag_id])
    if product_tags
      @product_tags = product_tags
    end
    respond_with @product_tags
  end

  def search_by(type,data)
    @product_tags = nil
    product_tags = ProductTag.search_by(type,data)
    if product_tags
      @product_tags = product_tags
    end
    respond_with @product_tags
  end

  # GET /product_tags/search_by_product/:product_id
  def search_by_product
    return search_by('product_id',params[:product_id])
  end

  # GET /product_tags/search_by_tag/:tag_id
  def search_by_tag
    return search_by('tag_id',params[:tag_id])
  end

  # POST /product_tags
  def create
    @product_tag  = nil
    aux_product_tags = ProductTag.search(params[:product_id],params[:tag_id])
    if aux_product_tags
      respond_with @product_tag
    else
      @product_tag = ProductTag.new(product_tag_params)
      @product_tag.save
      respond_with @product_tag
    end
  end

  # POST /product_tags
  def update  
    aux_product_tags = ProductTag.search(params[:product_id],params[:tag_id])
    if aux_product_tags && (aux_product_tags[0][:id] != product_tag[:id])
      respond_with @product_tag
    else
      @product_tag.update(product_tag_params)
      respond_with @product_tag
    end
  end

  # Delete
  def destroy
    @product_tag.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set Product
    def set_product_tag
      @product_tag = ProductTag.find_by(id: params[:id])
    end

    def product_tag_params
      params.require(:product_tag).permit(:id, :product_id, :tag_id)
    end
end
