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

class User < ApplicationRecord
  include SearchableTenanted

  rolify
  has_secure_password

  before_save :set_first_and_last_name
  after_create :close_invitation, :create_preference, :set_channel

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validate :has_invitation

  belongs_to :invitation, optional: true
  has_one :preference
  has_many :cards
  has_many :decks
  has_many :notifications
  has_many :card_followers, dependent: :destroy
  has_many :cards_following, through: :card_followers, source: :card
  has_many :messages

  def team
    subdomain = Apartment::Tenant.current.downcase
    Team.find_by_subdomain(subdomain)
  end

  def reload_card_follows(app)
    cards = Card.where(app: app)
    card_followers = cards.map { |c| { card: c, user: self } }
    CardFollower.first_or_create(card_followers)
  end

  private
  def set_first_and_last_name
    segments = self.name.split(' ')
    self.name = self.name.titleize
    self.first_name = segments.first.titleize
    self.last_name = segments.last.titleize
  end

  def has_invitation
    if Invitation.where(email: self.email).count === 0
      self.errors.add(:invitation, "was not found")
    end
  end

  def close_invitation
    inv = Invitation.find_by_email(self.email)
    inv.update(accepted: true)
    self.update(invitation_id: inv.id)
    self.add_role(:basic)
    self.add_role(:admin) if inv.admin
  end

  def create_preference
    self.build_preference.save
  end

  def set_channel
    uuid = SecureRandom.uuid
    self.update(channel: "private-#{Apartment::Tenant.current.downcase}-user_#{uuid}")
  end

end
