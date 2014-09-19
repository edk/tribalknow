class AppConfig < ActiveRecord::Base
  validates_presence_of :key, :value
  
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
end
