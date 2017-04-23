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
#

class Team < ApplicationRecord

  after_create :create_tenant, :create_invitation
  
  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true
  validates :email, presence: true

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

end
