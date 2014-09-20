
class Question < ActiveRecord::Base
  stampable
  acts_as_taggable
  has_paper_trail
  acts_as_votable
  include EventMessage

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders]

  # TODO add to_param and associated magic to make urls to questions nicer than the ids currently in use
  has_many   :answers, :dependent => :destroy
  belongs_to :user
  validates  :title, :text, presence: true, length: { minimum: 3 }
  belongs_to :topic

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  default_scope { where(tenant_id:Tenant.current_id) if Tenant.current_id }
  
  scope :asked_by, ->(user) { where(:creator_id => user.id ) }

  def to_s
    title
  end

  def class_as_verb
    "asked"
  end
end
