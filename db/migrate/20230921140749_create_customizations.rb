class CreateCustomizations < ActiveRecord::Migration[7.0]
  def change
    create_table :customizations, id: :uuid do |t|
      t.string :key
      t.string :content

      t.timestamps

      t.index :key, unique: true
    end
  end
end
