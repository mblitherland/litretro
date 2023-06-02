class CreateIcebreakers < ActiveRecord::Migration[7.0]
  def change
    create_table :icebreakers, id: :uuid do |t|
      t.uuid :retro_id
      t.string :question

      t.timestamps
    end
  end
end
