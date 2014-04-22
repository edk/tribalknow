class CreateMultimedia < ActiveRecord::Migration
  def change
    create_table :multimedia do |t|
      t.string     :title
      t.text       :description
      t.references :tenant, index: true
      t.references :topic, :index=>true
      t.text       :timeline
      t.text       :content

      t.userstamps
      t.timestamps
    end
  end
end
