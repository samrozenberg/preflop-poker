class AddCodeToDeckCards < ActiveRecord::Migration[6.0]
  def change
    add_column :deck_cards, :code, :string
  end
end
