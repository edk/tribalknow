class CreateAppConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :app_configs do |t|
      t.integer :tenant_id
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :app_configs, [:tenant_id]
    add_index :app_configs, [:key]
  end
end
