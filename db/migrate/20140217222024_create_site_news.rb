class CreateSiteNews < ActiveRecord::Migration[5.2]
  def change
    create_table :site_news do |t|
      t.belongs_to :tenant
      t.string :title
      t.text :text

      t.timestamps
    end
    add_index :site_news, [:tenant_id, :created_at]
  end
end
