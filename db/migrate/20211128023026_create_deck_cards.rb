class CreateDeckCards < ActiveRecord::Migration[6.0]
  def change
    create_table :deck_cards do |t|
      t.string :name
      t.timestamps
    end
  end
end
