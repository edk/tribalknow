class CreateTranscodeRemotes < ActiveRecord::Migration
  def change
    create_table :transcode_remotes do |t|
      t.integer  :video_asset_id
      t.integer  :job_id
      t.integer  :status
      t.text     :response
      t.datetime :last_checked

      t.timestamps
    end
    add_index :transcode_remotes, :video_asset_id
  end
end
