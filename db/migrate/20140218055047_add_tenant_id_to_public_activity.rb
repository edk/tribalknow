class AddTenantIdToPublicActivity < ActiveRecord::Migration
  def change
    add_column :activities, :tenant_id, :integer
    add_index :activities, [:tenant_id, :created_at]
  end
end
