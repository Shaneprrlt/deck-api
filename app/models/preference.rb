# == Schema Information
#
# Table name: preferences
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  app           :jsonb
#  notifications :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Preference < ApplicationRecord
  include Storext.model

  belongs_to :user

  ## App Settings ##
  store_attributes :app do

  end

  ## Notifications Settings ##
  store_attributes :notifications do
    card_is_created Hash[Symbol => Boolean], default: { push_notification: true, email: true }
    card_changes_status Hash[Symbol => Boolean], default: { push_notification: true, email: true }
    previous_card_reoccurs Hash[Symbol => Boolean], default: { push_notification: true, email: true }
    message_is_created Hash[Symbol => Boolean], default: { push_notification: true, email: false }
    app_is_created Hash[Symbol => Boolean], default: { push_notification: true, email: true }
  end
end
