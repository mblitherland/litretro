class AddLastColorToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_color, :string, default: "yellow"
  end
end
