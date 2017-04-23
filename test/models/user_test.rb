# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  invitation_id   :integer
#  email           :string
#  username        :string
#  name            :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  timezone        :string
#  phone           :string
#  blocked         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
