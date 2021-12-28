class AddStateToUserHands < ActiveRecord::Migration[6.0]
  def change
    add_column :user_hands, :active, :boolean
  end
end
