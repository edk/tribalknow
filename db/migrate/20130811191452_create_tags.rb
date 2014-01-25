class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text   :description
      t.references :tenant, index: true
      
      t.userstamps
      t.timestamps
    end
    add_index :tags, :name
  end
end
