class ProductsController < ApplicationController
  before_action :set_product

  respond_to :json

  # GET /products
  def index
    @products = Product.all
    respond_with @products
  end

  # GET /products/bestsellers
  def bestsellers
    @products = Product.all[0,6]
    respond_with @products
  end

  # GET /products/:id
  def show
    respond_with @product
  end

  # GET /products/search/:data
  def search
    @products = nil
    products = Product.search(params[:data])
    if products
      @products = products
    end
    respond_with @products
  end

  # POST /products
  def create
    @product  = nil
    aux_product = Product.find_by(name: product_params[:name])
    if aux_product
      respond_with @product
    else
      @product = Product.new(product_params)
      @product.save
      respond_with @product  
    end
  end

  # POST /products
  def update
    @product  = nil
    aux_product = Product.find_by(name: product_params[:name])
    if aux_product
      respond_with @product
    else
      @product.update(product_params)
      respond_with @product  
    end
  end

  # Delete
  def destroy
    @product.destroy
    redirect_to root_path
  end

  private
    # Set Product
    def set_product
      @product = Product.find_by(id: params[:id])
    end

    def product_params
      params.require(:product).permit(:id, :name, :stock_amount, :sales_amount, :photo)
    end

end
