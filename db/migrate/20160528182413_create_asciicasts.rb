class CreateAsciicasts < ActiveRecord::Migration
  def change
    create_table :asciicasts do |t|
      t.string :name
      t.text :description

      t.attachment :content

      t.integer  :creator_id
      t.integer  :updater_id
      t.timestamps
    end
  end
end

