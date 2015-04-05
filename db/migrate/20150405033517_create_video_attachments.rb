class CreateVideoAttachments < ActiveRecord::Migration
  def change
    create_table :video_attachments do |t|
      t.integer :tenant_id
      t.integer :video_asset_id

      t.string   :name
      t.text     :description

      t.string   :asset_file_name
      t.string   :asset_content_type
      t.integer  :asset_file_size
      t.datetime :asset_updated_at

      t.integer  :creator_id
      t.integer  :updater_id

      t.timestamps
    end
  end
end
