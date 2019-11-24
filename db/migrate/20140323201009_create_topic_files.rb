class CreateTopicFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_files do |t|
      t.belongs_to :topic
      t.timestamps
    end
  end
end
