json.array! @invitations do |invitation|
  json.(invitation, :id, :email, :admin, :resent_at, :created_at, :updated_at)
end
