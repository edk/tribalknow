
class Question < ActiveRecord::Base
  stampable
  simple_tagging

  # TODO add to_param and associated magic to make urls to questions nicer than the ids currently in use
  has_many   :answers
  belongs_to :user
  validates  :title, :text, presence: true, length: { minimum: 3 }

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user } 
    
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

end
