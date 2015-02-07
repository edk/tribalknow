class CreateCustomizedPages < ActiveRecord::Migration
  def change
    create_table :customized_pages do |t|
      t.boolean :active, default: false
      t.integer :tenant_id
      t.string  :page
      t.string  :title

      t.string  :position1
      t.text    :header1
      t.text    :content1

      t.string  :position2
      t.text    :header2
      t.text    :content2

      t.string  :position3
      t.text    :header3
      t.text    :content3

      t.string  :position4
      t.text    :header4
      t.text    :content4

      t.userstamps
      t.timestamps
    end

    add_index :customized_pages, [:tenant_id, :page]
    add_index :customized_pages, :page
  end
end
