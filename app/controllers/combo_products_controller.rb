class ComboProductsController < ApplicationController
  before_action :set_combo_product

  respond_to :json

  # GET /combo_products
  def index
    @combo_products = ComboProduct.all
    respond_with @combo_products
  end

  # GET /combo_product/:id
  def show
    respond_with @combo_product
  end

  # GET /combo_products/search/:combo_id/:product_id
  def search
    @combo_products = nil
    combo_products = ComboProduct.search(params[:combo_id],params[:product_id])
    if combo_products
      @combo_products = combo_products
    end
    respond_with @combo_products
  end

  def search_by(type,data)
    @combo_products = nil
    combo_products = ComboProduct.search_by(type,data)
    if combo_products
      @combo_products = combo_products
    end
    respond_with @combo_products
  end

  # GET /combo_products/search_by_product/:product_id
  def search_by_product
    return search_by('product_id',params[:product_id])
  end

  # GET /combo_products/search_by_combo/:combo_id
  def search_by_combo
    return search_by('combo_id',params[:combo_id])
  end

  # POST /combo_products
  def create
    @combo_product  = nil
    aux_combo_products = ComboProduct.search(params[:combo_id],params[:product_id])
    if aux_combo_products
      respond_with @combo_product
    else
      @combo_product = ComboProduct.new(combo_product_params)
      @combo_product.save
      respond_with @combo_product
    end
  end

  # POST /combo_products
  def update  
    @combo_product  = nil
    aux_combo_products = ComboProduct.search(params[:combo_id],params[:product_id])
    if aux_combo_products
      respond_with @combo_product
    else
      @combo_product.update(combo_product_params)
      respond_with @combo_product
    end
  end

  # Delete
  def destroy
    @combo_product.destroy
    redirect_to root_path
  end

  private
    # Set ComboProduct
    def set_combo_product
      @combo_product = ComboProduct.find_by(id: params[:id])
    end

    def combo_product_params
      params.require(:combo_product).permit(:id, :product_id, :combo_id)
    end
end
