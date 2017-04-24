# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deck < ApplicationRecord

  validates :title, presence: true, length: { minimum: 5, maximum: 140 }

  belongs_to :user

  has_many :deck_labels, dependent: :destroy
  has_many :labels, through: :deck_labels
  
  has_many :deck_cards, dependent: :destroy
  has_many :cards, through: :deck_cards

  def clear_labels
    deck_labels.destroy_all
    self
  end

  def add_cards_to_deck

    # find cards this deck contained that may no longer belong
    # based on removed labels and remove those cards from this deck
    cards = self.cards.joins(card_labels: [:label]).where.not("labels.id IN (?)", self.labels.collect(&:id)).distinct
    self.deck_cards.where(card: cards).destroy_all

    # find cards this deck should have and add them to it
    self.cards << Card.joins(card_labels: [:label]).where.not(id: self.deck_cards.collect(&:card_id)).where("labels.id IN (?)", self.labels.collect(&:id)).distinct

  end

end
