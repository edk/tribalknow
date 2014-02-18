class SiteNews < ActiveRecord::Base
  model_stamper
  belongs_to :tenant
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
  

  scope :latest, -> { order(:created_at).limit(10) }
end
