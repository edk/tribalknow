class AddUserstampsToSiteNews < ActiveRecord::Migration[5.2]
  def change
    add_column :site_news, :creator_id, :integer
    add_column :site_news, :updater_id, :integer
  end
end
