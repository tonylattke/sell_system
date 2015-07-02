json.array!(@bill_articles) do |bill_article|
  json.extract! bill_article, :id, :price_id, :amount, :bill_id
end
