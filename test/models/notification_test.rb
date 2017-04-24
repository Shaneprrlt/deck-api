# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  action      :integer
#  actor_type  :string
#  actor_id    :integer
#  target_type :string
#  target_id   :integer
#  read        :boolean          default(FALSE), not null
#  uuid        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
