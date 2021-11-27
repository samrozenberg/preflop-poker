class DeleteUserIdToHand < ActiveRecord::Migration[6.0]
  def change
    remove_column :hands, :user_id
  end
end
