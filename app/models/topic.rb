class Topic < ActiveRecord::Base
  # Topic.where('? = ANY(tags)', 'li')
  # Topic.where( 'tags @> ARRAY[?]', ['unix', 'bash'] )
  
  stampable

  # http://monkeyandcrow.com/blog/tagging_with_active_record_and_postgres/
  scope :any_tags, -> (tags){where('tags && ARRAY[?]', tags)}
  scope :all_tags, -> (tags){where('tags @> ARRAY[?]', tags)}
  
  has_many   :sub_topics, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:parent_topic
  belongs_to :parent_topic, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:sub_topics
  validates  :name, presence: true, length: { minimum: 3 }

  def self.topic_select
    Topic.where("parent_topic_id is NULL")
  end

  before_save :update_tag_cache

  def update_tag_cache
    Tag.add_new_tags(self.tags) if self.tags.present?
  end
  
end

