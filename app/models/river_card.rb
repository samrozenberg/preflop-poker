class RiverCard < ApplicationRecord
  belongs_to :deck_card
  belongs_to :hand
end
