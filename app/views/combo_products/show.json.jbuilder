if @combo_product
  json.extract! @combo_product, :id, :product_id, :combo_id, :product_amount
end
