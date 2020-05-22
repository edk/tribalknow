class CreateVideoAccessSecrets < ActiveRecord::Migration[5.2]
  def change
    create_table :video_access_secrets do |t|
      t.belongs_to :video_asset, index: true
      t.string :value

      t.timestamps
    end
  end
end
