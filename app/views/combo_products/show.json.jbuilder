if @combo_product
  json.extract! @combo_product, :id, :product_id, :combo_id
end
