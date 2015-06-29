json.array!(@products) do |product|
  json.extract! product, :id, :name, :stock_amount, :sales_amount, :photo, :prices, :active
end
