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

class Team < ApplicationRecord

  after_create :create_tenant, :create_invitation, :set_channel

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true
  validates :email, presence: true
  validate :valid_subdomain

  private
  def create_tenant
    Apartment::Tenant.create(self.subdomain)
  end

  def create_invitation
    Apartment::Tenant.switch!(self.subdomain)

    # create the admin invitation
    Invitation.create({
      email: self.email,
      admin: true
    })
  end

  def valid_subdomain
    if ['www','api','api-staging','s3','support','help','blog','contact','about'].exists?(self.subdomain)
      errors.add(:subdomain, "invalid")
    end
  end

  def set_channel
    uuid = SecureRandom.uuid
    self.update(channel: "presence-#{self.subdomain.downcase}-team_#{uuid}")
  end

end
