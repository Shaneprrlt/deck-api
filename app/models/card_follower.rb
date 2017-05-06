# == Schema Information
#
# Table name: card_followers
#
#  id         :integer          not null, primary key
#  card_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardFollower < ApplicationRecord
  belongs_to :card
  belongs_to :user

  validates_presence_of :card_id, scope: :user_id
end
