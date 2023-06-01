class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.uuid :retro_id
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
