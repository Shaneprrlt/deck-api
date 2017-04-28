json.platforms @platforms do |platform|
  json.(platform, :id, :name, :icon, :created_at, :updated_at)
end
