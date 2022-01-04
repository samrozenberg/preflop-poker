class AddUrlToDeckCards < ActiveRecord::Migration[6.0]
  def change
    add_column :deck_cards, :url, :string
  end
end
