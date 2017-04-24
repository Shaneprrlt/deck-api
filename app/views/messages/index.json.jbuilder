json.array! @messages do |message|
  json.(message, :id, :card_id, :body, :created_at, :updated_at)

  json.user do
    json.(message.user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)

    json.roles message.user.roles do |role|
      json.(role, :id, :name, :resource_type, :resource_id, :created_at, :updated_at)
    end
  end
end
