class AddButtonToHands < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :button, foreign_key: { to_table: :users }
  end
end
