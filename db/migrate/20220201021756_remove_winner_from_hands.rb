class RemoveWinnerFromHands < ActiveRecord::Migration[6.0]
  def change
    remove_column :hands, :winner_id
  end
end
