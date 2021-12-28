class AddScoreToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :score, :integer
  end
end
