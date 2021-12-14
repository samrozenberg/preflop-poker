class AddUserIdToBets < ActiveRecord::Migration[6.0]
  def change
    add_reference :bets, :user, null: false, foreign_key: true
  end
end
