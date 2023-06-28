class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards, id: :uuid do |t|
      t.uuid :column_id
      t.string :column_desc
      t.string :color
      t.string :title
      t.string :discussion
      t.integer :votes
      t.integer :user_id

      t.timestamps
    end
  end
end
