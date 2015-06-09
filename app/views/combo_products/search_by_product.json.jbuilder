json.array!(@combo_products) do |combo_product|
  json.extract! combo_product, :id, :product_id, :combo_id
end
