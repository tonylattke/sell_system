json.array!(@combos) do |combo|
  json.extract! combo, :id, :name, :stock_amount, :sales_amount, :photo, :prices
end
