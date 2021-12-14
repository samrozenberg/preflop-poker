class UserCard < ApplicationRecord
  belongs_to :user
  belongs_to :deck_card
  belongs_to :hand
end
