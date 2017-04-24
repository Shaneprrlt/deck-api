require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do

  task import_data_for_all_tenants: :environment do

    ## Untenanted Models ##
    Apartment::Tenant.switch!

    Platform.import force: true
    CardType.import force: true

    ## Tenanted Models ##
    Team.pluck(:subdomain).each do |subdomain|
      Apartment::Tenant.switch!(subdomain)

      User.import force: true
      Notification.import force: true
      Message.import force: true
      Label.import force: true
      Card.import force: true
      Deck.import force: true
    end

  end

end
