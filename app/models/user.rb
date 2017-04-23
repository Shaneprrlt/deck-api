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

class User < ApplicationRecord
  has_secure_password

  before_save :set_first_and_last_name
  after_create :close_invitation

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :invitation, presence: false

  validate :has_invitation

  has_one :invitation

  private
  def set_first_and_last_name
    segments = self.name.split(' ')
    self.first_name = segments.first
    self.last_name = segments.last
  end

  def has_invitation
    if Invitation.where(email: self.email).count === 0
      self.errors.add(:invitation, "was not found")
    end
  end

  def close_invitation
    inv = Invitation.find_by_email(self.email)
    self.update(invitation_id: inv.id)
  end

end
