json.(@deck, :id, :title, :created_at, :updated_at)

json.labels do
  json.array! @deck.labels do |_label|
    json.(_label, :id, :title, :created_at, :updated_at)

    if _label.app
      json.app do
        json.(_label.app, :id, :name, :created_at, :updated_at)

        json.platform do
          json.(_label.app.platform, :id, :name, :icon, :created_at, :updated_at)
        end

        json.developers _label.app.contributors do |user|
          json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)
        end
      end
    end
  end
end

json.cards do

  json.array! @deck.cards.order(created_at: :desc).page(@page) do |card|

    json.(card, :id, :title, :description, :state, :uuid, :occurences, :share_url, :created_at, :updated_at)

    if @current_user
      json.following @current_user.cards_following.exists?(card)
    end

    json.user do
      json.(card.user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)

      json.roles card.user.roles do |role|
        json.(role, :id, :name, :resource_type, :resource_id, :created_at, :updated_at)
      end
    end

    json.card_type do
      json.(card.card_type, :id, :name, :icon, :created_at, :updated_at)
    end

    json.app do
      json.(card.app, :id, :name, :created_at, :updated_at)

      json.platform do
        json.(card.app.platform, :id, :name, :icon, :created_at, :updated_at)
      end

      json.developers card.app.contributors do |user|
        json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)
      end
    end

    json.labels do
      json.array! card.labels do |_label|

        json.(_label, :id, :title, :created_at, :updated_at)

        if _label.app
          json.app do
            json.(_label.app, :id, :name, :created_at, :updated_at)

            json.platform do
              json.(_label.app.platform, :id, :name, :icon, :created_at, :updated_at)
            end

            json.developers _label.app.contributors do |user|
              json.(user, :id, :username, :email, :name, :first_name, :last_name, :phone, :timezone, :blocked)
            end
          end
        end
      end
    end
  end
end
