class Answer < ActiveRecord::Base
  belongs_to :question
  validates  :text, presence: true, length: { minimum: 3 }
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
end
