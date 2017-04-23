class SubdomainConstraint
  def self.matches?(request)
    segments = request.subdomain.split('.')
    request.subdomain.present? && segments.length > 1 && segments.last != 'www'
  end
end

Rails.application.routes.draw do

  ## Teams ##
  resources :teams, only: [:create, :show, :update, :destroy], defaults: { format: :json }

  constraints SubdomainConstraint do

    ## Invitations ##
    put '/invitations/:id/remind', to: "invitations#remind", as: :invitation_remind
    resources :invitations, only: [:index,:create,:destroy], defaults: { format: :json }

    ## Users ##
    resources :users, only: [:index, :create, :update, :destroy], defaults: { format: :json }

  end
end
