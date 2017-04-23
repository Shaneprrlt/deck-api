# == Schema Information
#
# Table name: cards
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  card_type_id :integer
#  app_id       :integer
#  title        :string
#  description  :string
#  state        :integer
#  uuid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
