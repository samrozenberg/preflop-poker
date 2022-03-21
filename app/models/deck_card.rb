class DeckCard < ApplicationRecord
  has_many :user_cards, dependent: :destroy
  has_many :flop_cards, dependent: :destroy
  has_many :turn_cards, dependent: :destroy
  has_many :river_cards, dependent: :destroy
  has_many :card_hands, dependent: :destroy
  has_many :hands, through: :card_hands, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
