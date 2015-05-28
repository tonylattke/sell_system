class ClientsController < ApplicationController
  before_action :set_client

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/:id
  # GET /clients/:id.json
  def show
  end

  # GET /clients/search/:data
  # GET /clients/search/:data.json
  def search
    @client = nil
    clients = Client.search(params[:data])
    if clients
      @client = clients[0]
    end
  end

  private
    # Set Client
    def set_client
      @client = Client.find_by(id: params[:id])
    end

end
