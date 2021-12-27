class RemoveStateFromReservations < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :state
  end
end
