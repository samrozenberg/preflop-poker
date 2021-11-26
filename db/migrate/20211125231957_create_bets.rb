class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.references :hand, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
