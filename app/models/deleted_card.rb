class DeletedCard < ApplicationRecord
  belongs_to :hand
  belongs_to :deck_card
end
