class TurnCard < ApplicationRecord
  belongs_to :card
  belongs_to :hand
end
