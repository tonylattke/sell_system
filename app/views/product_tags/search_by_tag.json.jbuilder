json.array!(@product_tags) do |product_tag|
  json.extract! product_tag, :id, :product_id, :tag_id
end
