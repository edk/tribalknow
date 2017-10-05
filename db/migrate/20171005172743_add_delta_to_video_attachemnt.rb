class AddDeltaToVideoAttachemnt < ActiveRecord::Migration
  def change
    add_column :video_attachments, :delta, :boolean, :default=>true, :null=>false
  end
end
