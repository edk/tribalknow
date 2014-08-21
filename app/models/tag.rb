
class Tag
  def self.tag_collection
    ActsAsTaggableOn::Tag.all.order(:name).map {|t| [t.name, t.name]}
  end
  def self.all_tags
    ActsAsTaggableOn::Tag.all.order(:name).pluck(:name)
  end  
end
