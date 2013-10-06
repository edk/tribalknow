module SimpleTagging
  def simple_tagging
    # http://monkeyandcrow.com/blog/tagging_with_active_record_and_postgres/
    scope :any_tags, -> (tags){where('tags && ARRAY[?]', tags)}
    scope :all_tags, -> (tags){where('tags @> ARRAY[?]', tags)}

    before_save :update_tag_cache
    include InstanceMethods
  end
  module InstanceMethods
    def update_tag_cache
      Tag.add_new_tags(self.tags) if self.tags.present?
    end
  end
end

ActiveRecord::Base.extend SimpleTagging

