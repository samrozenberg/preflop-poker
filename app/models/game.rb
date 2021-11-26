class Game < ApplicationRecord
  has_many :reservations
  validates :name, presence: true
  has_many :hands
  has_many :bets, through: :hands
  has_many :users, through: :reservations
end
