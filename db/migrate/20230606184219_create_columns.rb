class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns, id: :uuid do |t|
      t.uuid :retro_id
      t.string :name
      t.integer :rank

      t.timestamps
    end
  end
end
