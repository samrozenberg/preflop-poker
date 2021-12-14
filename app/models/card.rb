class Card < ApplicationRecord
<<<<<<< HEAD
  has_many :user_cards
  has_many :flop_cards
  has_many :turn_cards
  has_many :river_cards
=======
  has_many :card_hands
  has_many :hands, through: :card_hands
>>>>>>> 50b3cfa673b817e7fa44b83ed0f003962e7650c7
  validates :name, presence: true, uniqueness: true
end
