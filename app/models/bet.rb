class Bet < ApplicationRecord
  belongs_to :hand
  belongs_to :user
end
