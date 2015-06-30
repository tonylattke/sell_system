class ProductProvidersController < ApplicationController
  before_action :set_product_provider

  respond_to :json

  # GET /product_providers
  def index
    @product_providers = ProductProvider.all
    respond_with @product_providers
  end

  # GET /product_providers/:id
  def show
    respond_with @product_provider
  end

  # GET /product_providers/search/:product_id/:provider_id
  def search
    @product_providers = nil
    product_providers = ProductProvider.search(params[:product_id],params[:provider_id])
    if product_providers
      @product_providers = product_providers
    end
    respond_with @product_providers
  end

  def search_by(type,data)
    @product_providers = nil
    product_providers = ProductProvider.search_by(type,data)
    if product_providers
      @product_providers = product_providers
    end
    respond_with @product_providers
  end

  # GET /product_providers/search_by_product/:product_id
  def search_by_product
    return search_by('product_id',params[:product_id])
  end

  # GET /product_providers/search_by_provider/:provider_id
  def search_by_provider
    return search_by('provider_id',params[:provider_id])
  end

  # POST /product_providers
  def create
    aux_product_providers = ProductProvider.search(params[:product_id],params[:provider_id])
    if aux_product_providers
      respond_with @product_provider
    else
      @product_provider = ProductProvider.new(product_provider_params)
      @product_provider.save
      respond_with @product_provider
    end
  end

  # POST /product_providers
  def update  
    aux_product_providers = ProductProvider.search(params[:product_id],params[:provider_id])
    if aux_product_providers  && (aux_product_providers[0][:id] != product_provider_params[:id])
      respond_with @product_provider
    else
      @product_provider.update(product_provider_params)
      respond_with @product_provider
    end
  end

  # Delete
  def destroy
    @product_provider.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set Product
    def set_product_provider
      @product_provider = ProductProvider.find_by(id: params[:id])
    end

    def product_provider_params
      params.require(:product_provider).permit(:id, :product_id, :provider_id)
    end
end
