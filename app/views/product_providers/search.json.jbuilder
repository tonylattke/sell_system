json.array!(@product_providers) do |product_provider|
  json.extract! product_provider, :id, :product_id, :provider_id
end
