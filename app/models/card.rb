class Card < ApplicationRecord
  has_many :user_cards
  has_many :flop_cards
  has_many :turn_cards
  has_many :river_cards
  validates :name, presence: true, uniqueness: true
end
