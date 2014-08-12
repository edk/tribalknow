class MyDeviseMailer < Devise::Mailer
  default :from => { Tenant.current.try(:fqdn) ? "system@#{Tenant.current.try(:fqdn)}" : "system@tribalknownow.com" }

end
