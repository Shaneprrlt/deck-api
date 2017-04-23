# == Schema Information
#
# Table name: apps
#
#  id          :integer          not null, primary key
#  name        :string
#  platform_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  removed     :boolean          default(FALSE), not null
#

require 'test_helper'

class AppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
