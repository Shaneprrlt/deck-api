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
    # a new card has been added to your deck!
    # only notify user if they haven't already
    # received a notification about this card
  end
end
