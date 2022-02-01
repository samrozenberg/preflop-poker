class CreateHandWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :hand_winners do |t|
      t.references :hand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
