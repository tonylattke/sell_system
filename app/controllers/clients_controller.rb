class ClientsController < ApplicationController
  before_action :set_client

  respond_to :json

  # GET /clients
  def index
    @clients = Client.all
    respond_with @clients
  end

  # GET /clients/:id
  def show
    respond_with @client
  end

  # GET /clients/search/:data
  def search
    @client = nil
    clients = Client.search(params[:data])
    if clients
      @client = clients[0]
    end
    respond_with @client
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    @client.save
    respond_with @client
  end

  # POST /clients
  def update
    @client.update(client_params)
    respond_with @client
  end

  # Delete
  def destroy
    @client.destroy
    redirect_to root_path
  end

  private
    # Set Client
    def set_client
      @client = Client.find_by(id: params[:id])
    end

    def client_params
      params.require(:client).permit(:dni, :name, :balance)
    end

end
