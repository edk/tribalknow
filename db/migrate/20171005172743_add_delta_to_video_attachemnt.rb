class AddDeltaToVideoAttachemnt < ActiveRecord::Migration[5.2]
  def change
    add_column :video_attachments, :delta, :boolean, :default=>true, :null=>false
  end
end
