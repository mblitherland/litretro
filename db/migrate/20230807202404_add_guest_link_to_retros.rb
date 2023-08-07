class AddGuestLinkToRetros < ActiveRecord::Migration[7.0]
  def change
    add_column :retros, :guest_link, :uuid
    add_column :users, :guest, :boolean
  end
end
