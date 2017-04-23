# == Schema Information
#
# Table name: card_labels
#
#  id         :integer          not null, primary key
#  card_id    :integer
#  label_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardLabel < ApplicationRecord
  belongs_to :card
  belongs_to :label
end
