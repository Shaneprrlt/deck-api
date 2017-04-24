# == Schema Information
#
# Table name: deck_cards
#
#  id         :integer          not null, primary key
#  deck_id    :integer
#  card_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeckCard < ApplicationRecord
  after_create :notify_user

  belongs_to :deck
  belongs_to :card

  validates :card, uniqueness: { scope: :deck }
  
  private
  def notify_user
    unless self.deck.user.id === self.card.user.id
      Notification.first_or_create(
        user: self.deck.user,
        action: :created_card,
        actor: self.card.user,
        target: self.card
      )
    end
  end
end
