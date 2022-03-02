class AddTypeToHands < ActiveRecord::Migration[6.0]
  def change
    add_column :hands, :type, :string
  end
end
