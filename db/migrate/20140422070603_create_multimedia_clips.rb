class CreateMultimediaClips < ActiveRecord::Migration
  def change
    create_table  :multimedia_clips do |t|
      t.references :multimedia, index: true
      t.references :tenant, index: true
      t.integer    :position # order in the list of multimedia clips
      t.string     :title
      t.string     :type
      t.integer    :size
      t.integer    :seconds
      t.text       :data
      t.attachment :file

      t.userstamps
      t.timestamps
    end
  end
end
