class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :topic_id
      t.string :title
      t.text :text
      t.text :tags, :array=>true, :default=>'{}'
      t.references :tenant

      t.userstamps
      t.timestamps
    end
    add_index(:questions, :tags, :using => 'gin')
  end
end
