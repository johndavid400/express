class AddSiteIdToChannels < ActiveRecord::Migration[5.1]
  def change
    add_column :channels, :site_id, :integer
  end
end
