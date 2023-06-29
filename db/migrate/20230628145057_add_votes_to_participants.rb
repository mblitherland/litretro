class AddVotesToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :votes, :integer, :default => 5
  end
end
