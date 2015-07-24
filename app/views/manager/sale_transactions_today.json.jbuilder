json.array!(@sale_transactions) do |sale_transaction|
  json.extract! sale_transaction, :id, :amount, :type_t
end
