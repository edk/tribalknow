class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :subdomain
      t.string :domain

      t.timestamps
    end
    add_index :tenants, :subdomain
    add_index :tenants, :domain
  end
end
