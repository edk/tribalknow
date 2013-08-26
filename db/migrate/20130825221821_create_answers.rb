class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.integer :score, :default=>0

      t.userstamps
      t.timestamps
    end
  end
end
