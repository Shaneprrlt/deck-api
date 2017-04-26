class Notifier

  ## Will Deliver a Notification Based On User Settings ##
  def self.send_notification(user, notification)

    ## Construct Payload ##
    payload = {
      id: notification.id,
      uuid: notification.uuid,
      actor_type: notification.actor_type,
      actor_id: notification.actor_id,
      target_type: notification.target_type,
      target_id: notification.target_id
    }

    ## Determine Preferences ##
    preferences = get_preferences(user.preference, notification)
    if preferences[:push_notification]
      payload[:push_notification] = true
    end

    ## If Email, Fire Notification Mailer ##
    if preferences[:email]
      ## todo: send email
      # send_email(user, notification)
    end

    ## Push to Clients ##
    PushEventJob.perform_later(user.channel, notification.action, payload)

  end

  ## Gets a Preference Based off Notification Action ##
  def self.get_preferences(preference, notification)
    actions = Notification.actions

    case notification.action
    when 'created_card'
      return preference.card_is_created
    when 'updated_card_status'
      return preference.card_changes_status
    when 'created_card_occurence'
      return preference.previous_card_reoccurs
    when 'created_message'
      return preference.message_is_created
    when 'app_created'
      return preference.app_is_created
    end
  end

end
