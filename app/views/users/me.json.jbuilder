json.(@user, :id, :username, :email, :name, :first_name, :last_name, :phone, :channel, :timezone, :blocked)

json.roles @user.roles do |role|
  json.(role, :id, :name, :resource_type, :resource_id, :created_at, :updated_at)
end

json.preference do
  json.(@user.preference, :card_is_created, :card_changes_status, :previous_card_reoccurs, :message_is_created, :app_is_created)
end
