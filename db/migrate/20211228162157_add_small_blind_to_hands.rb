class AddSmallBlindToHands < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :small_blind, foreign_key: { to_table: :users }
  end
end
