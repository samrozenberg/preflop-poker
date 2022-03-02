class RenameTypeInHands < ActiveRecord::Migration[6.0]
  def change
    rename_column :hands, :type, :name
  end
end
