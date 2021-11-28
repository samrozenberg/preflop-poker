class Hand < ApplicationRecord
  belongs_to :game
  has_many :bets
  has_many :user_hands
  has_many :users, through: :user_hands
  has_many :card_hands
  has_many :cards, through: :card_hands
end
