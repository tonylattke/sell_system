json.array!(@cash_transactions) do |cash_transaction|
  json.extract! cash_transaction, :id, :created_at, :amount, :description, :type_t
end