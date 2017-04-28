json.notification do
  json.(@notification, :id, :action, :actor_type, :actor_id, :target_type, :target_id, :read, :created_at, :updated_at)
end
