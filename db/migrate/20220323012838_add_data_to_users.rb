class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hand_played, :integer
    add_column :users, :hand_won, :integer
  end
end
