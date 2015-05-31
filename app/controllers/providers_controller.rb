class ProvidersController < ApplicationController
  before_action :set_provider

  respond_to :json

  # GET /providers
  def index
    @providers = Provider.all
    respond_with @providers
  end

  # GET /providers/:id
  def show
    respond_with @provider
  end

  # GET /providers/search/:data
  def search
    @provider = nil
    providers = Provider.search(params[:data])
    if providers
      @provider = providers[0]
    end
    respond_with @provider
  end

  # POST /providers
  def create
    @provider  = nil
    aux_provider = Provider.find_by(name: provider_params[:name])
    if aux_provider
      respond_with @provider
    else
      @provider = Provider.new(provider_params)
      @provider.save
      respond_with @provider  
    end
  end

  # POST /providers
  def update
    @provider  = nil
    aux_provider = Provider.find_by(name: provider_params[:name])
    if aux_provider
      respond_with @provider
    else
      @provider.update(provider_params)
      respond_with @provider  
    end
  end

  # Delete
  def destroy
    @provider.destroy
    redirect_to root_path
  end

  private
    # Set provider
    def set_provider
      @provider = Provider.find_by(id: params[:id])
    end

    def provider_params
      params.require(:provider).permit(:name)
    end

end
