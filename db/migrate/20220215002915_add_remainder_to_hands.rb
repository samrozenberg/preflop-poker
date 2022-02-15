class AddRemainderToHands < ActiveRecord::Migration[6.0]
  def change
    add_column :hands, :remainder, :integer
  end
end
