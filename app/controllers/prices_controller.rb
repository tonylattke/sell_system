class PricesController < ApplicationController
  before_action :set_price

  respond_to :json

  # GET /prices
  def index
    @prices = Price.all
    respond_with @prices
  end

  # GET /prices/:id
  def show
    respond_with @price
  end

  # POST /prices
  def create
    @price = Provider.new(price_params)
    @price.save
    respond_with @price
  end

  def search_by(type,data)
    @prices = nil
    prices = Price.search_by(type,data)
    if prices
      @prices = prices
    end
    respond_with @prices
  end

  # GET /prices/search_by_product/:product_id
  def search_by_product
    return search_by('product_id',params[:product_id])
  end

  # GET /prices/search_by_combo/:combo_id
  def search_by_combo
    return search_by('combo_id',params[:combo_id])
  end

  # POST /prices
  def update
    @price.update(price_params)
    respond_with @price  
  end

  # Delete
  def destroy
    @price.destroy
    redirect_to root_path
  end

  private
    # Set price
    def set_price
      @price = Provider.find_by(id: params[:id])
    end

    def price_params
      params.require(:price).permit(:id,:product_id,:combo_id,:value,:created_at,:type_option)
    end
end
