class Harbinger

  ## Will Deliver a Message To This Card's Channel ##
  def self.send_message(card, message)

    ## Construct Payload ##
    payload = {
      id: message.id
    }

    ## Push to Clients ##
    PushEventJob.perform_later(card.channel, Settings.new_message_event, payload)

  end

end
