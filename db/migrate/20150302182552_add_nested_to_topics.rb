class AddNestedToTopics < ActiveRecord::Migration[5.2]
  def self.up
    PaperTrail.enabled = false
    # add_column :topics, :parent_id, :integer # Comment this line if your project already has this column
    Topic.where(parent_topic_id: 0).update_all(parent_topic_id: nil) # Uncomment this line if your project already has :parent_id
    add_column :topics, :lft,       :integer
    add_column :topics, :rgt,       :integer

    # optional fields
    add_column :topics, :depth,          :integer
    add_column :topics, :children_count, :integer

    # adding position for sorting
    add_column :topics, :position, :integer

    add_index :topics, [:tenant_id, :parent_topic_id]
    add_index :topics, [:tenant_id, :lft]
    add_index :topics, [:tenant_id, :rgt]
    add_index :topics, [:tenant_id, :depth]

    # This is necessary to update :lft and :rgt columns
    Topic.rebuild!
    PaperTrail.enabled = true
  end

  def self.down
    remove_column :topics, :parent_id
    remove_column :topics, :lft
    remove_column :topics, :rgt

    # optional fields
    remove_column :topics, :depth
    remove_column :topics, :children_count

    remove_column :topics, :position

    remove_index :topics, [:tenant_id, :parent_topic_id]
    remove_index :topics, [:tenant_id, :lft]
    remove_index :topics, [:tenant_id, :rgt]
    remove_index :topics, [:tenant_id, :depth]
  end

end
