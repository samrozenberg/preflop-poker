class HandWinner < ApplicationRecord
  belongs_to :hand
  belongs_to :winner, class_name: "User"
end
