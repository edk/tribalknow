class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :parent_topic_id
      t.string  :name
      t.string  :description
      t.string  :tags, :array=>true, :default=>'{}'
      t.text    :content

      t.timestamps
    end
  end
end
