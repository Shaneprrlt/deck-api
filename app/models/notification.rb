# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  action      :integer
#  actor_type  :string
#  actor_id    :integer
#  target_type :string
#  target_id   :integer
#  read        :boolean          default(FALSE), not null
#  uuid        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ApplicationRecord
  include SearchableTenanted

  before_create :set_uuid
  after_create :send_notification

  belongs_to :user
  belongs_to :actor, polymorphic: true
  belongs_to :target, polymorphic: true

  enum action: {
    created_card: 100,
    updated_card_status: 200,
    created_card_occurence: 300,
    created_message: 400,
    app_created: 500
  }

  def self.unread_count(user)
    user.notifications.where(read: false).count
  end

  def send_notification
    # todo: add notification settings,
    # and send to the user based on their
    # notifications settings
  end

  private
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
