class AddHandIdToUserCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_cards, :hand, null: false, foreign_key: true
  end
end
