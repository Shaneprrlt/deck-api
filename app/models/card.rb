# == Schema Information
#
# Table name: cards
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  card_type_id :integer
#  app_id       :integer
#  title        :string
#  description  :string
#  state        :integer
#  uuid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Card < ApplicationRecord
  include AASM

  after_create :set_app_label, :set_uuid, :create_initial_occurence

  validates :title, presence: true, length: { minimum: 10, maximum: 500 }
  validates :description, presence: true, length: { minimum: 20, maximum: 5000 }

  belongs_to :user
  belongs_to :card_type
  belongs_to :app
  has_many :card_occurences
  has_many :card_labels
  has_many :labels, through: :card_labels

  enum state: {
    created: 100,
    started: 200,
    finished: 300,
    delivered: 400,
    completed: 500,
    rejected: 600,
    closed: 700
  }

  aasm column: :state, enum: true do
    state :created, initial: true
    state :started
    state :finished
    state :delivered
    state :completed
    state :rejected
    state :closed

  end

  def contributors
    self.app.contributors
  end

  def share_url
    subdomain = Apartment::Tenant.current.downcase
    "https://#{subdomain}.deckapp.io/#{self.uuid}"
  end

  def occurences
    self.card_occurences.count
  end

  def clear_labels
    card_labels.joins(:label).where("labels.app_id IS NULL").destroy_all
  end

  private
  def set_app_label
    self.labels << Label.where(app: self.app).first
  end

  def set_uuid
    self.update(uuid: SecureRandom.uuid)
  end

  def create_initial_occurence
    self.card_occurences.create(user: self.user)
  end

end
