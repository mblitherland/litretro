class AddStateToRetros < ActiveRecord::Migration[7.0]
  def change
    add_column :retros, :state, :integer, default: 0
  end
end
