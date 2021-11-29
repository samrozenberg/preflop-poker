class Card < ApplicationRecord
  has_many :card_hands
  has_many :user_cards
  has_many :hands, through: :card_hands
  validates :name, presence: true, uniqueness: true
end
