json.array! @users do |user|
  json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)
end
