class AddFlagsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :flags, :string
  end
end
