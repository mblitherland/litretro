class AddSelfRegisterToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :guest, :boolean, default: false
  end
end
