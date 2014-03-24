class CreateTopicFiles < ActiveRecord::Migration
  def change
    create_table :topic_files do |t|
      t.belongs_to :topic
      t.timestamps
    end
  end
end
