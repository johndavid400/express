class CreateEntryTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :entry_types do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :description
      t.json :data
      t.string :status
      t.string :attachment_uid
      t.string :attachment_name
      t.string :attachment_size

      t.timestamps
    end
  end
end
