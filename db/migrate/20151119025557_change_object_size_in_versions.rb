class ChangeObjectSizeInVersions < ActiveRecord::Migration
  def change
    change_column :versions, :object_changes, :text, :limit => 16777215
  end
end
