class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations
  has_many :user_hands
  has_many :bets
  has_many :user_cards
  has_many :cards, through: :user_cards
  has_many :hands, through: :user_hands
  has_many :games, through: :reservations
  validates :name, presence: true
  validates :pseudo, presence: true, uniqueness: true
end
