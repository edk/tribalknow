class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :topic_id
      t.text :text
      t.text :tags, :array=>true, :default=>'{}'

      t.userstamps
      t.timestamps
    end
    add_index(:questions, :tags, :using => 'gin')
  end
end
