class AppConfig < ApplicationRecord
  validates_presence_of :key
  
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  def self.[] key, default = nil
    conf = AppConfig.find_by(key: key)
    if conf.value
      conf.value
    else
      conf.value.nil? ? default : conf.value
    end if conf
  end
  
end
