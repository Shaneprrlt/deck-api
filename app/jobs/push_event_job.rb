class PushEventJob < ApplicationJob
  queue_as :default

  ## When Push Notifications Fail ##
  rescue_from Pusher::Error do |exception|
    retry_job wait: 2.minutes, queue: :low_priority
  end

  def perform(channel, event, payload)
    Pusher.trigger(channel, event, data: payload)
  end
end
