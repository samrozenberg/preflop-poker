class DeckCard < ApplicationRecord
  has_many :user_cards
  has_many :flop_cards
  has_many :turn_cards
  has_many :river_cards
  has_many :card_hands
  has_many :hands, through: :card_hands
  validates :name, presence: true, uniqueness: true
end
