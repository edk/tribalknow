class Tenant < ActiveRecord::Base
  validates :name, presence: true
  validates :domain, uniqueness: true, allow_nil:true
  validates :subdomain, uniqueness: true, allow_nil:true

  def self.current_id=(id)
    Thread.current[:tenant_id]=id
  end
  def self.current_id
    Thread.current[:tenant_id]
  end

  def self.default_tenant
    Tenant.find_by subdomain:"coupa"
  end
end


