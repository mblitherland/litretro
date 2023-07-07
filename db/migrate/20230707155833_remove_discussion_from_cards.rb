class RemoveDiscussionFromCards < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :discussion, :string
  end
end
