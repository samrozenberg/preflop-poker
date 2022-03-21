class Hand < ApplicationRecord
  belongs_to :game
  belongs_to :button, class_name: "User", dependent: :destroy
  belongs_to :small_blind, class_name: "User", dependent: :destroy
  belongs_to :big_blind, class_name: "User", dependent: :destroy
  belongs_to :better, class_name: "User", dependent: :destroy
  has_many :bets, dependent: :destroy
  has_many :user_hands, dependent: :destroy
  has_many :user_cards, dependent: :destroy
  has_many :deleted_cards, dependent: :destroy
  has_many :flop_cards, dependent: :destroy
  has_many :turn_cards, dependent: :destroy
  has_many :river_cards, dependent: :destroy
  has_many :hand_winners, dependent: :destroy
  has_many :users, through: :user_hands, dependent: :destroy
end
