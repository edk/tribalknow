class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.integer :parent_topic_id
      t.string  :name
      t.string  :description
      t.text    :content
      t.references :tenant, index: true

      t.userstamps
      t.timestamps
    end
  end
end
