module ClientHelper

  def clients_list
    return Client.all
  end

  def client_create(client_params)
    client  = nil
    aux_client = Client.find_by(dni: client_params[:dni])
    if aux_client
      nil
    else
      client = Client.new(client_params)
      client.save
    end
    return client
  end

end
