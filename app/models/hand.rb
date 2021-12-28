class Hand < ApplicationRecord
  belongs_to :game
  belongs_to :button, class_name: "User"
  belongs_to :small_blind, class_name: "User"
  belongs_to :big_blind, class_name: "User"
  has_many :bets
  has_many :user_hands
  has_many :user_cards
  has_many :flop_cards
  has_many :turn_cards
  has_many :river_cards
  has_many :users, through: :user_hands
end
