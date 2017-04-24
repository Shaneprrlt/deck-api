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

require 'test_helper'

class CardFollowerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
