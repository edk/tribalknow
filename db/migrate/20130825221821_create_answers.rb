class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer  :question_id
      t.text     :text
      t.integer  :score, :default=>0

      t.userstamps
      t.timestamps
    end
    add_index(:answers, :question_id)
  end
end
