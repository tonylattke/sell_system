json.array!(@combos) do |combo|
  json.extract! combo, :id, :name, :sales_amount, :photo, :prices, :active, :combo_products
end
