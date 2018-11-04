class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :fqdn, uniqueness: true, allow_nil:true
  validates :subdomain, uniqueness: true, allow_nil:true
  has_settings do |s|
    s.key :topic, :defaults=>{:heading=>'All topics'}
    s.key :question, :defaults=>{:heading=>'Questions'}
  end

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end
  
  def self.current_id
    Thread.current[:tenant_id]
  end

  def self.current
    @current_tenant ||= Tenant.find_by_id(current_id)
  end

  def self.default_tenant
    def_tenant = Tenant.where(:default=>true).first
  end

  def self.multi_tenant?
    Tenant.where(:default=>true).none?
  end

  def self.default_title
    current.try(:site_title).presence || "TribalKnowNow"
  end

  def self.default_footer
    current.try(:footer).presence || "TribalKnowNow Copyright #{Date.today.year}"
  end

  def email_domain_requires_approval? email
    if self.safe_domains.present?
      domains = self.safe_domains.split(',')
      !domains.any? { |domain| email =~ /.*@#{domain}/ }
    else
      true
    end
  end

end


