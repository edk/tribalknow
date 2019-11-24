class CreateDocs < ActiveRecord::Migration[5.2]
  def change
    create_table :docs do |t|
      t.string :doc_group_id
      t.string :name
      t.string :type
      t.string :description
      t.string :path     # may be fully qualified
      t.string :basepath # always path - Rails.root
      t.text   :data

      t.timestamps
    end
    
    add_index :docs, :basepath
    add_index :docs, :doc_group_id
  end
end
