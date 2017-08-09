class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads do |t|
      t.string :name
      t.integer :entry_id
      t.string :attachment_uid
      t.string :attachment_name
      t.string :attachment_size

      t.timestamps
    end
  end
end
