class EnlargeAssetFileSize < ActiveRecord::Migration
  def up
    change_column :file_assets, :asset_file_size, :int, :limit => 8
  end
  
  def down
    change_column :file_assets, :asset_file_size, :int, :limit => 5
  end
end
