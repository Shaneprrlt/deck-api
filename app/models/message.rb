# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  card_id    :integer
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
  after_create :notify_followers

  validates :body, presence: true, length: { minimum: 3, maximum: 5000 }

  belongs_to :user
  belongs_to :card

  private
  def notify_followers
    # todo: send a notification to anybody
    # who is following or receiving notifications
    # for the associated card
  end
end
