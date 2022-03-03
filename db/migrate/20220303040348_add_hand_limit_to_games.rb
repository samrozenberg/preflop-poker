class AddHandLimitToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :hand_limit, :integer
  end
end
