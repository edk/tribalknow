class AddDeltaIndexingToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :delta, :boolean, :default=>true, :null=>false
    add_column :answers, :delta, :boolean, :default=>true, :null=>false
    add_column :questions, :delta, :boolean, :default=>true, :null=>false
    add_column :notes, :delta, :boolean, :default=>true, :null=>false
  end
end
