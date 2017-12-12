class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :slug
      t.json :config
      t.text :description
      t.string :key

      t.timestamps
    end
  end
end
