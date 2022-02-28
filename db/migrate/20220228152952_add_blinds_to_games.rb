class AddBlindsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :sb_amount, :integer
    add_column :games, :bb_amount, :integer
    add_column :games, :max_bet_amount, :integer
  end
end
