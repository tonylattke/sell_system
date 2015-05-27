json.array!(@clients) do |client|
  json.extract! client, :id, :dni, :name, :subscription_date, :balance
end
