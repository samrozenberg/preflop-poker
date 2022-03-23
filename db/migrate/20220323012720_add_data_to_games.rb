class AddDataToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :amount_played, :integer
    add_column :games, :hand_count, :integer
  end
end
