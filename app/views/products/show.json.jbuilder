if @product
  json.extract! @product, :id, :name, :stock_amount, :sales_amount, :photo
end
