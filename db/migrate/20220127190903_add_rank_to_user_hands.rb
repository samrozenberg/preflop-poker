class AddRankToUserHands < ActiveRecord::Migration[6.0]
  def change
    add_column :user_hands, :rank, :string
  end
end
