class CreateRestaurantComments < ActiveRecord::Migration
  def change
    create_table :restaurant_comments do |t|
      t.string :author
      t.text :body
      t.integer :rank
      t.belongs_to :restaurant

      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      t.timestamps null: false
    end
  end
end
