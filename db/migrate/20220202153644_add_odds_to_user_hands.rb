class AddOddsToUserHands < ActiveRecord::Migration[6.0]
  def change
    add_column :user_hands, :odds, :string
  end
end
