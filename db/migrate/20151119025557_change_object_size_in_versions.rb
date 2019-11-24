class ChangeObjectSizeInVersions < ActiveRecord::Migration[5.2]
  def change
    change_column :versions, :object_changes, :text, :limit => 16777215
  end
end
