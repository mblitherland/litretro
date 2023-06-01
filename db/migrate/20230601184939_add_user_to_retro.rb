class AddUserToRetro < ActiveRecord::Migration[7.0]
  def change
    add_column :retros, :user_id, :integer
  end
end
