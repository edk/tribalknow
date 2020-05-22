class AddTenantIdToPublicActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :tenant_id, :integer
    add_index :activities, [:tenant_id, :created_at]
  end
end
