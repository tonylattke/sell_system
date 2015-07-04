if @client
  json.extract! @client, :id, :dni, :name, :subscription_date, :balance, :active
end
