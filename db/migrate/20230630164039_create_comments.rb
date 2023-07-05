class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :comment
      t.uuid :card_id
      t.integer :user_id

      t.timestamps
    end
  end
end
