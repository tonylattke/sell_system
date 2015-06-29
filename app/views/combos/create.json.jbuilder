if @combo
  json.extract! @combo, :id, :name, :stock_amount, :sales_amount, :photo, :prices, :active
end
