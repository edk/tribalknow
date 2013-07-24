class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :parent_topic_id
      t.string  :name
      t.string  :description
      t.text    :tags, :array=>true, :default=>'{}'
      # see http://adamsanderson.github.io/railsconf_2013/?full#10 for info on the prev line
      t.text    :content

      t.userstamps
      t.timestamps
    end
  end
end
