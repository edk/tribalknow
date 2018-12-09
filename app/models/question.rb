
class Question < ApplicationRecord
  stampable
  acts_as_taggable
  has_paper_trail
  acts_as_votable
  include EventMessage

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders]

  has_many   :answers, :dependent => :destroy
  has_many   :uniq_answerers, -> { distinct }, through: :answers, :source=>:creator
  belongs_to :user
  validates  :title, presence: true, length: { minimum: 3 }
  belongs_to :topic

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  scope :asked_by, ->(user) { where(:creator_id => user.id ) }

  scope :popular, ->(limit=10) {
    joins(:votes_for).where('votes.vote_flag' => '1').group(:votable_id).select("questions.*, count(votes.id) as vote_count").order("vote_count desc, votable_id desc").limit(limit)
  }

  def to_s
    title
  end

  def class_as_verb
    "asked"
  end
end
