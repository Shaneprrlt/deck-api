# == Schema Information
#
# Table name: public.teams
#
#  id         :integer          not null, primary key
#  name       :string
#  subdomain  :string
#  email      :string
#  timezone   :string
#  blocked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel    :string
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
