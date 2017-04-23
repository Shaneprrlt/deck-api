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
    post '/users/login', to: "users#login", as: :login
    resources :users, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json }

    ## Platforms ##
    resources :platforms, only: [:index], defaults: { format: :json }

    ## Apps ##
    resources :apps, only: [:index, :create, :show, :update], defaults: { format: :json }

  end
end
