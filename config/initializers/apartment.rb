require 'apartment/elevators/subdomain'

Apartment.configure do |config|
  config.excluded_models = ['Team','Platform','CardType','Settings']
  config.tenant_names = lambda{ Team.pluck(:subdomain) }
end

Rails.application.config.middleware.use 'Apartment::Elevators::Subdomain'
