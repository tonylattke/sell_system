if @client
  json.extract! @client, :id, :dni, :name, :balance, :active
end
