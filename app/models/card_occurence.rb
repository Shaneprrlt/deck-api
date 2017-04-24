# == Schema Information
#
# Table name: card_occurences
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  card_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardOccurence < ApplicationRecord

  after_create :notify_contributors

  belongs_to :user
  belongs_to :card
  
  private
  def notify_contributors
    self.card.contributors.each do |user|
      Notification.create(
        user: user,
        action: :created_card_occurence,
        actor: self.user,
        target: self.card
      )
    end
  end
end
