class AddParentToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :parent_card, :uuid
  end
end
