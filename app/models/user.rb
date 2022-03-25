class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations, dependent: :destroy
  has_many :user_hands, dependent: :destroy
  has_many :bets, dependent: :destroy
  has_many :user_cards, dependent: :destroy
  has_many :deck_cards, through: :user_cards
  has_many :hands, through: :user_hands, dependent: :destroy
  has_many :games, through: :reservations
  # has_many :hand_winners, dependent: :destroy
  has_one_attached :photo
  validates :name, presence: true
  validates :pseudo, presence: true, uniqueness: true
  belongs_to :best_hand, class_name: "Hand", optional: true
  belongs_to :worst_hand, class_name: "Hand", optional: true
end
