class AddBigBlindToHands < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :big_blind, foreign_key: { to_table: :users }
  end
end
