class AddHandStatsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :best_hand, foreign_key: { to_table: :hands }, null: true
    add_reference :users, :worst_hand, foreign_key: { to_table: :hands }, null: true
    add_column :users, :biggest_win, :integer
    add_column :users, :biggest_loss, :integer
  end
end
