if @sale_transaction
  json.extract! @sale_transaction, :id, :bill, :amount, :type_t
end