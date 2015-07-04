json.array!(@bills) do |bill|
  json.extract! bill, :id, :created_at, :client_id, :bill_articles
end
