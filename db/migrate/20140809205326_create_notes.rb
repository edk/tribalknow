class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :path
      t.string :title
      t.text :content

      t.userstamps
      t.timestamps
    end
    add_index :notes, :path
  end
end
