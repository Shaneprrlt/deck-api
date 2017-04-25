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

class Invitation < ApplicationRecord
  before_destroy :protect_admin_invitation

  private
  def protect_admin_invitation
    if self.admin
      errors.add(:admin, "cannot destroy admin invitation")
    end
  end
end
