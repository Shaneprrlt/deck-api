namespace :seed_data do

  ## App Platforms ##
  desc "Seeds Database with Default App Platforms"
  task app_platforms: :environment do
    Platform.create([
      { name: 'iOS', icon: 'fa-apple' },
      { name: 'Android', icon: 'fa-android' },
      { name: 'Web', icon: 'fa-globe' },
      { name: 'Service', icon: 'fa-database' },
      { name: 'Desktop', icon: 'fa-laptop' },
      { name: 'Other', icon: 'fa-cog' }
    ])
  end

  ## Card Types ##
  desc "Seeds Database with Default Card Types"
  task card_types: :environment do
    CardType.create([
      { name: 'Feature Request' },
      { name: 'Bug' }
    ])
  end

end
