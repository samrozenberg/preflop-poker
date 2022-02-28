class Game < ApplicationRecord
  has_many :reservations
  validates :name, presence: true
  validates :sb_amount, presence: true
  validates :bb_amount, presence: true
  validates :max_bet_amount, presence: true
  has_many :hands
  has_many :bets, through: :hands
  has_many :users, through: :reservations
end
