# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  email      :string
#  admin      :boolean          default(FALSE), not null
#  accepted   :boolean          default(FALSE), not null
#  resent_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
