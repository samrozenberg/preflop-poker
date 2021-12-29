class AddBetterIdToHands < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :better, foreign_key: { to_table: :users }
  end
end
