json.label do
  json.(@label, :id, :title, :created_at, :updated_at)

  if @label.app
    json.app do
      json.(@label.app, :id, :name, :created_at, :updated_at)

      json.platform do
        json.(@label.app.platform, :id, :name, :icon, :created_at, :updated_at)
      end

      json.developers @label.app.contributors do |user|
        json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :channel, :timezone, :blocked)
      end
    end
  end
end
