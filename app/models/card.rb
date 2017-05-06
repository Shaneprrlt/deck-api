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
#  channel      :string
#

class Card < ApplicationRecord
  include SearchableTenanted
  include AASM

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :description, analyzer: 'english'
    end
  end

  before_create :set_uuid, :set_channel
  after_create :set_app_label, :create_initial_occurence, :add_default_followers, :set_channel, :send_created_notification

  validates :title, presence: true, length: { minimum: 10, maximum: 500 }
  validates :description, presence: true, length: { minimum: 20, maximum: 5000 }

  belongs_to :user
  belongs_to :card_type
  belongs_to :app
  has_many :card_occurences, dependent: :destroy
  has_many :card_labels, dependent: :destroy
  has_many :labels, through: :card_labels
  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards
  has_many :messages
  has_many :card_followers, dependent: :destroy
  has_many :followers, through: :card_followers, source: :user

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
    self
  end

  def apply_to_decks

    # find decks this card is in but no longer may belong to
    # based on removed labels and remove this card from them
    decks = self.decks.joins(deck_labels: [:label]).where.not("labels.id IN (?)", self.labels.collect(&:id)).distinct
    self.deck_cards.where(deck: decks).destroy_all

    # find decks we should be in and add this card to them
    decks = Deck.joins(deck_labels: [:label]).where.not(id: self.deck_cards.collect(&:deck_id)).where("labels.id IN (?)", self.labels.collect(&:id)).distinct

    # Manually create join instances in order to boost
    # performance (by executing in 1 query)
    DeckCard.create( decks.map { |d| { deck: d, card: self } } )

  end

  private
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def set_channel
    self.channel = "presence-#{Apartment::Tenant.current.downcase}-card_#{self.uuid}"
  end

  def set_app_label
    self.labels << Label.where(app: self.app).first
  end

  def create_initial_occurence
    self.card_occurences.create(user: self.user)
  end

  def add_default_followers
    CardFollower.create(card: self, user: self.user)
    self.contributors.each { |u| CardFollower.create(card: self, user: u) }
  end

  def send_created_notification
    notifications = self.followers.map do |u|
      {
        user: u,
        action: :created_card,
        actor: self.user,
        target: self
      }
    end
    Notification.create(notifications)
  end

end
