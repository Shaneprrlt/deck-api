json.(@user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked, :roles)
json.roles @user.roles do |role|
  json.(role, :id, :name)
end
