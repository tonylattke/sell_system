if @combo
  json.extract! @combo, :id, :name, :stock_amount, :sales_amount, :photo, :prices, :active, :combo_products
end
