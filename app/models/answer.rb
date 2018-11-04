class Answer < ApplicationRecord
  stampable
  has_paper_trail
  acts_as_votable
  include EventMessage

  belongs_to :question
  validates  :text, presence: true, length: { minimum: 3 }
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
  scope :answered_by, ->(user) { where(:creator_id => user.id) }

  alias_attribute :title, :text

  def to_s
    question && question.title
  end

  def class_as_verb
    "answered"
  end

end
