class RiverCard < ApplicationRecord
  belongs_to :card
  belongs_to :hand
end