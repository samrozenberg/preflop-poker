class Hand < ApplicationRecord
  belongs_to :game
  has_many :bets
  has_many :user_hands
  has_many :user_cards
  has_many :flop_cards
  has_many :turn_cards
  has_many :river_cards
  has_many :users, through: :user_hands
end
