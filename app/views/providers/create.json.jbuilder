if @provider
  json.extract! @provider, :id, name, :created_at, :updated_at
end
