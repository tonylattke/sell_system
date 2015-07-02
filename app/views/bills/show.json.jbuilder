if @bill
  json.extract! @bill, :id, :created_at, :client_id
end
