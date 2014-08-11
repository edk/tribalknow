class RenameDomainToFqdn < ActiveRecord::Migration
  def change
    rename_column :tenants, :domain, :fqdn
  end
end
