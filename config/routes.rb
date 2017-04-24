class SubdomainConstraint
  def self.matches?(request)
    segments = request.subdomain.split('.')
    request.subdomain.present? && segments.last != 'www'
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
    get '/me', to: "users#me", as: :me, defaults: { format: :json }
    post '/users/login', to: "users#login", as: :login, defaults: { format: :json }
    put '/users/:id/update_role', to: "users#update_role", as: :user_update_role, defaults: { format: :json }
    resources :users, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json }

    ## Platforms ##
    resources :platforms, only: [:index], defaults: { format: :json }

    ## Apps ##
    resources :apps, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json } do
      get '/cards', to: "apps#cards", as: :cards
    end

    ## Card Types ##
    resources :card_types, only: [:index], defaults: { format: :json }

    ## Labels ##
    resources :labels, only: [:index, :create, :show], defaults: { format: :json }

    ## Cards ##
    resources :cards, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json } do
      put '/mark_occurence', to: "cards#mark_occurence", as: :mark_occurence
      put '/follow', to: "cards#follow", as: :follow
      put '/unfollow', to: "cards#unfollow", as: :unfollow

      ## Messages ##
      resources :messages, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json }
    end

    ## Decks ##
    resources :decks, only: [:index, :create, :show, :update, :destroy], defaults: { format: :json }

    ## Notifications ##
    put '/notifications/mark_all_as_read', to: "notifications#mark_all_as_read", defaults: { format: :json }
    resources :notifications, only: [:index], defaults: { format: :json } do
      put '/mark_as_read', to: "notifications#mark_as_read", as: :mark_as_read
    end

  end
end
