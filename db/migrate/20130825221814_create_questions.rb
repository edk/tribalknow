class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :topic_id
      t.string :title
      t.text :text
      t.references :tenant, index: true

      t.userstamps
      t.timestamps
    end
  end
end
