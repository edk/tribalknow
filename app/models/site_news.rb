class SiteNews < ApplicationRecord
  stampable
  belongs_to :tenant
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
  

  scope :latest, ->(last_time=nil) { 
    last_time ? order(:created_at).where('created_at > ?', last_time).limit(10) :
                order(:created_at).limit(10)
  }
end
