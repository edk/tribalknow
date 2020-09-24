class CreateContentFixups < ActiveRecord::Migration[6.0]
  def change
    create_table :content_fixups do |t|
      t.string :name
      t.string :description
      t.string :from_regex
      t.string :to_string

      t.timestamps
      t.index :name, unique: true
    end
  end
end
