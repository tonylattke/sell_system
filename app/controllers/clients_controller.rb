class ClientsController < ApplicationController
  before_action :set_client

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /client/1
  # GET /client/1.json
  def show
  end

  private
    # Set Client
    def set_client
      @client = Client.find_by(id: params[:id])
    end

end
