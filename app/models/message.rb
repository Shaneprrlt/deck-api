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
  include SearchableTenanted

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :body, analyzer: 'english'
    end
  end

  after_create :follow_card, :send_message, :notify_followers

  validates :body, presence: true, length: { minimum: 3, maximum: 5000 }

  belongs_to :user
  belongs_to :card

  private
  def follow_card
    CardFollower.first_or_create(card: self.card, user: self.user)
  end

  def send_message
    Harbinger.send_message(card, self)
  end

  def notify_followers
    self.card.followers.each do |user|
      Notification.first_or_create(
        user: user,
        action: :created_message,
        actor: self.user,
        target: self
      )
    end
  end
end
