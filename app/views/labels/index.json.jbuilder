json.labels @labels do |_label|

  json.(_label, :id, :title, :created_at, :updated_at)

  if _label.app
    json.app do
      json.(_label.app, :id, :name, :created_at, :updated_at)

      json.platform do
        json.(_label.app.platform, :id, :name, :icon, :created_at, :updated_at)
      end

      json.developers _label.app.contributors do |user|
        json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :channel, :timezone, :blocked)
      end
    end
  end

end
