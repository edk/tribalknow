class AddDefaultTenantField < ActiveRecord::Migration
  def change
    add_column :tenants, :default, :boolean, :default=>false
    add_column :tenants, :site_title, :text
    add_column :tenants, :landing_page, :text
    add_column :tenants, :footer, :text
  end
end
