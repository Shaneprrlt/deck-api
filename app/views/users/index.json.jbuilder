json.array! @users do |user|
  json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)

  json.roles user.roles do |role|
    json.(role, :id, :name, :resource_type, :resource_id, :created_at, :updated_at)
  end
end
