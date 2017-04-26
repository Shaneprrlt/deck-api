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
  after_create :send_email
  before_destroy :protect_admin_invitation, :ensure_unaccepted

  has_one :user

  private
  def send_email
    InvitationMailer.prepare(self).deliver_later
  end

  def protect_admin_invitation
    if self.admin
      errors.add(:admin, "cannot destroy admin invitation")
    end
  end

  def ensure_unaccepted
    if self.accepted
      errors.add(:accepted, "cannot destroy accepted invitation")
    end
  end
end
