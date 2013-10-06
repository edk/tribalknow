class Topic < ActiveRecord::Base
  stampable
  simple_tagging

  has_many   :sub_topics, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:parent_topic
  belongs_to :parent_topic, :class_name=>'Topic', :foreign_key => 'parent_topic_id', :inverse_of=>:sub_topics
  validates  :name, presence: true, length: { minimum: 3 }

  searchable do
    text :name, :description, :content
    text :tags do
      tags.join(', ')
    end
  end

  def self.topic_select
    Topic.where("parent_topic_id is NULL")
  end

end

