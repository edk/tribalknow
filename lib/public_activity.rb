#class PublicActivity::Activity
#  belongs_to :tenant
#  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
#end
