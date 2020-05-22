class SiteNews < ApplicationRecord
  stampable
  belongs_to :tenant

  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  scope :latest, ->(last_time=nil) { 
    last_time ? order(:created_at).where('created_at > ?', last_time).limit(10) :
                order(:created_at).limit(10)
  }
end
