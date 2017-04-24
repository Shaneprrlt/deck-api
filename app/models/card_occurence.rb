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
    # todo: let the contributors know another
    # instance of this card has occured
  end

end
