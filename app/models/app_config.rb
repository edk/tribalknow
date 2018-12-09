class AppConfig < ApplicationRecord
  validates_presence_of :key
  
  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  def self.[] key, default = nil
    conf = AppConfig.find_by(key: key)
    if conf.value
      conf.value
    else
      conf.value.nil? ? default : conf.value
    end if conf
  end
  
end
