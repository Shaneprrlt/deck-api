# == Schema Information
#
# Table name: preferences
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  app           :jsonb
#  notifications :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PreferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
