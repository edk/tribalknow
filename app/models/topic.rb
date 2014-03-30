class Topic < ActiveRecord::Base
  stampable
  simple_tagging
  has_paper_trail
  
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many   :sub_topics, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:parent_topic
  belongs_to :parent_topic, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:sub_topics
  validates  :name, presence: true, length: { minimum: 3 }
  has_many   :topic_files
  has_many   :questions
  # has_many   :links
  # has_many   :contributors

  has_attached_file :icon, :styles => { :thumb => "100x100#" }, :default_url => "blank-icon-100x100.gif" #/images/:style/missing.png"
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/

  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user } 

  def self.topic_select
    Topic.where("parent_topic_id is NULL")
  end

end

