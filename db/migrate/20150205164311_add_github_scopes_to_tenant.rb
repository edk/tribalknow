class AddGithubScopesToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :required_github_organization, :string, default: nil
    add_column :tenants, :github_auth_failure_message, :text, default: nil
    add_column :users, :skip_confirmation, :boolean, default: false
    add_column :users, :skip_activation, :boolean, default: false
  end
end
