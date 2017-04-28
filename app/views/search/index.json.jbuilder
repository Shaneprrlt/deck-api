json.search_results @search_results do |record, hit|

  json.id SecureRandom.uuid
  json.score hit._score
  json.type hit._type

  ## Platform ##
  if hit._type === "platform"
    json.platform do
      json.(record, :id, :name, :icon, :created_at, :updated_at)
    end
  end

  ## CardType ##
  if hit._type === "card_type"
    json.card_type do
      json.(record, :id, :name, :icon, :created_at, :updated_at)
    end
  end

  ## User ##
  if hit._type === "user"
    json.user do
      json.(record, :id, :username, :email, :name, :first_name, :last_name, :phone, :channel, :timezone, :blocked)
    end
  end

  ## Deck ##
  if hit._type === "deck"
    json.deck do
      json.(record, :id, :title, :created_at, :updated_at)
    end
  end

  ## Card ##
  if hit._type === "card"
    json.card do
      json.(record, :id, :title, :description, :state, :uuid, :occurences, :share_url, :channel, :created_at, :updated_at)
    end
  end

  ## Message ##
  if hit._type === "message"
    json.message do
      json.(record, :id, :card_id, :body, :created_at, :updated_at)
    end
  end

  ## Label ##
  if hit._type === "label"
    json.label do
      json.(record, :id, :app_id, :title, :created_at, :updated_at)
    end
  end

end
