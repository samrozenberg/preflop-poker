class DropUserIdFromHands < ActiveRecord::Migration[6.0]
  def change
    remove_reference :hands, :user, index: true, foreign_key: true
  end
end
