# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  username        :string
#  name            :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  timezone        :string
#  phone           :string
#  blocked         :boolean          default(FALSE), not null
#  invitation_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  channel         :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
