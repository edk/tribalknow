class AddSafeDomainsToTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :safe_domains, :string
  end
end
