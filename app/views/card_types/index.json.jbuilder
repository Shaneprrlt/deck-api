json.array! @card_types do |ct|
  json.(ct, :id, :name, :icon, :created_at, :updated_at)
end
