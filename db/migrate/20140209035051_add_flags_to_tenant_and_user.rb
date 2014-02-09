class AddFlagsToTenantAndUser < ActiveRecord::Migration
  def change
    add_column :tenants, :new_user_restriction, :boolean, :default=>false
    add_column :tenants, :self_serve_allowed_domain, :string, :default=>nil
    add_column :users, :approved, :boolean, :default=>false
    add_index  :users, :approved
  end
end
