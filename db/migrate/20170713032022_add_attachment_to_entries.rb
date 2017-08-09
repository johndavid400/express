class AddAttachmentToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :attachment_uid,  :string
    add_column :entries, :attachment_name, :string
    add_column :entries, :attachment_size, :string
  end
end
