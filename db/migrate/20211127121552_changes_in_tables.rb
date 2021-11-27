class ChangesInTables < ActiveRecord::Migration[6.0]
  def change
    add_column :hands, :active, :boolean
    add_column :reservations, :state, :string
  end
end
