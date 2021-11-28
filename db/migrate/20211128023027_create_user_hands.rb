class CreateUserHands < ActiveRecord::Migration[6.0]
  def change
    create_table :user_hands do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
