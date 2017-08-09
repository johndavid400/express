class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.json :data
      t.string :type

      t.timestamps
    end
  end
end
