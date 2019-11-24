class EnlargeAssetFileSize < ActiveRecord::Migration[5.2]
  def up
    change_column :file_assets, :asset_file_size, :int, :limit => 8
  end
  
  def down
    change_column :file_assets, :asset_file_size, :int, :limit => 5
  end
end
