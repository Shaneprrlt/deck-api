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

require 'test_helper'

class DeckLabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
