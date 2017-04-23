require 'apartment/elevators/first_subdomain'

Apartment.configure do |config|
  config.excluded_models = ['Team']
  config.tenant_names = lambda{ Team.pluck(:subdomain) }
end

Rails.application.config.middleware.use 'Apartment::Elevators::FirstSubdomain'
