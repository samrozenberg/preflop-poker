class CreateFlopCards < ActiveRecord::Migration[6.0]
  def change
    create_table :flop_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.references :hand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
