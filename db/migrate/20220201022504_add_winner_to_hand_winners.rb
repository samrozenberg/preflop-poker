class AddWinnerToHandWinners < ActiveRecord::Migration[6.0]
  def change
    add_reference :hand_winners, :winner, foreign_key: { to_table: :users }
  end
end
