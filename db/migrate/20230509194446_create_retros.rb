class CreateRetros < ActiveRecord::Migration[7.0]
  def change
    create_table :retros, id: :uuid do |t|
      t.date :retro_date
      t.string :description

      t.timestamps
    end
  end
end
