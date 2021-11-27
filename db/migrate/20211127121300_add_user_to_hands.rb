class AddUserToHands < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :user, null: false, foreign_key: true
  end
end
