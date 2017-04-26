json.array! @apps do |app|
  json.(app, :id, :name, :created_at, :updated_at)
  json.platform do
    json.(app.platform, :id, :name, :icon, :created_at, :updated_at)
  end
  json.developers app.contributors do |user|
    json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :channel, :timezone, :blocked)
  end
end
