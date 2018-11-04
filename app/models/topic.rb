class Topic < ApplicationRecord
  stampable
  acts_as_taggable
  acts_as_votable
  has_paper_trail
  acts_as_nested_set parent_column: 'parent_topic_id', counter_cache: :children_count
  include EventMessage

  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many   :sub_topics, -> { order 'position, id' }, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:parent_topic
  belongs_to :parent_topic, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:sub_topics, touch: true
  validates  :name, presence: true, length: { minimum: 3 }
  has_many   :topic_files
  has_many   :questions
  has_many   :file_assets
  # has_many   :links
  # has_many   :contributors

  alias_attribute :title, :description

  has_attached_file :icon, :styles => { :thumb => "100x100#" }, :default_url => "blank-icon-100x100.gif" #/images/:style/missing.png"
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/

  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
  scope :created_by, ->(user) { where(:creator_id => user.id) }
  scope :updated_by, ->(user) { where(:updater_id => user.id) }

  def hierarchy
    harray, current = [], self

    while current = current.parent_topic
      harray << current
    end
    harray.reverse
  end

  def self.topic_select
    # Topic.where("parent_topic_id is NULL") can't show only roots if we have more than 1 level of nesting
    Topic.order("name ASC")
  end

  def to_s
    name
  end

end
