class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :description
      t.json :data
      t.string :status
      t.datetime :open
      t.datetime :close
      t.integer :user_id
      t.integer :channel_id

      t.timestamps
    end
  end
end
