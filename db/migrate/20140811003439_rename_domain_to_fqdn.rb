class RenameDomainToFqdn < ActiveRecord::Migration[5.2]
  def change
    rename_column :tenants, :domain, :fqdn
  end
end
