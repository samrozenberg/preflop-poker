class AddPotToHands < ActiveRecord::Migration[6.0]
  def change
    add_column :hands, :pot, :integer
  end
end
