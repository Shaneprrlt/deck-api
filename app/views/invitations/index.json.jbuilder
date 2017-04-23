json.array! @invitations do |invitation|
  json.(invitation, :id, :email, :admin, :accepted, :resent_at, :created_at, :updated_at)
end
