if @price
  if @price.type_option == 'p'
    json.extract! @price, :id, :product_id, :value, :created_at, :type_option, :bill_articles
  elsif @price.type_option == 'c'
    json.extract! @price, :id, :combo_id, :value, :created_at, :type_option, :bill_articles
  end
end
