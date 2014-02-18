class AddUserstampsToSiteNews < ActiveRecord::Migration
  def change
    add_column :site_news, :creator_id, :integer
    add_column :site_news, :updater_id, :integer
  end
end
