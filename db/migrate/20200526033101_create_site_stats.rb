class CreateSiteStats < ActiveRecord::Migration[5.2]
  def change
    # check in psql with
    # select count(*) from pg_extension where extname = 'hstore';
    enable_extension 'hstore' unless extension_enabled?('hstore')

    create_table :site_stats do |t|
      t.references :tenant, foreign_key: true
      t.string :name
      t.hstore :data

      t.timestamps
    end
    add_index :site_stats, :name
  end
end
