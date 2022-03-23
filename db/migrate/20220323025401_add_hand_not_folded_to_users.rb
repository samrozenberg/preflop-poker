class AddHandNotFoldedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hand_not_folded, :integer
  end
end
