# == Schema Information
#
# Table name: deck_labels
#
#  id         :integer          not null, primary key
#  deck_id    :integer
#  label_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeckLabel < ApplicationRecord
  belongs_to :deck
  belongs_to :label
end
