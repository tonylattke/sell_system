class CombosController < ApplicationController
  before_action :set_combo

  respond_to :json

  # GET /combos
  def index
    @combos = Combo.all
    respond_with @combos
  end

  # GET /combos/bestsellers
  def bestsellers
    @combos = Combo.searchBestsellers()[0,6]
    respond_with @combos
  end

  # GET /combos/:id
  def show
    respond_with @combo
  end

  # GET /combos/search/:data
  def search
    @combos = nil
    combos = Combo.search(params[:data])
    if combos
      @combos = combos
    end
    respond_with @combos
  end

  # POST /combos
  def create
    aux_combo = Combo.find_by(name: combo_params[:name])
    if aux_combo && (aux_combo[:id] != combo_params[:id])
      respond_with @combo
    else
      @combo = Combo.new(combo_params)
      @combo.save
      respond_with @combo  
    end
  end

  # POST /combos
  def update
    # aux_combo = Combo.find_by(name: combo_params[:name])
    # if aux_combo && (aux_combo[:id] != combo_params[:id])
    #   respond_with @combo
    # else
    #   @combo.update(combo_params)
    #   respond_with @combo  
    # end
    @combo.update(combo_params)
  end

  # Delete
  def destroy
    @combo.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set Combo
    def set_combo
      @combo = Combo.find_by(id: params[:id])
    end

    def combo_params
      params.require(:combo).permit(:id, :name, :sales_amount, :photo, :active)
    end

end
