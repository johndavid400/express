class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
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
