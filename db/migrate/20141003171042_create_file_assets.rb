class CreateFileAssets < ActiveRecord::Migration
  def change
    create_table :file_assets do |t|
      t.references :tenant, index: true
      t.belongs_to :parent
      t.string     :type
      t.belongs_to :topic
      t.string     :name
      t.text       :description
      t.boolean    :draft, default: false
      t.date       :date
      t.integer    :runtime

      t.string     :slug

      t.attachment :asset
      t.text :asset_meta

      t.userstamps
      t.timestamps

      add_index  :file_assets, :slug, :unique => true rescue nil
      add_index  :file_assets, :draft rescue nil
      add_index  :file_assets, :parent_id rescue nil
    end
  end
end
