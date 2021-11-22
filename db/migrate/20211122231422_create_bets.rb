class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.integer :amount
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
