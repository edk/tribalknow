class AddSafeDomainsToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :safe_domains, :string
  end
end
