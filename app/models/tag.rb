# this tag class is more like a cache of tags in the sysem.
# the tag usres don't actually reference any rows here since we are using postgress arrays to store the tags
# could potentially add a column to scope the tags later if needed
class Tag < ActiveRecord::Base
  validates :name, uniqueness: true, length: { minimum: 1 }

  # adds any new uniq tags to the db.  returns an array of all the tags.
  # takes an array of strings or a string with multiple tags separated by ,
  def self.add_new_tags tag_list
    tag_list = tag_list.split(',') if !tag_list.is_a? Array

    # add any that aren't already in the tags list
    return tag_list.each do |t|
      Tag.create(:name=>t) # don't care if it fails, do we?
    end

  end

  def self.rebuild_from_model klass
    klass.all.uniq.pluck('tags').uniq.flatten.each do |tag|
      Tag.where(name: tag).first_or_create
    end
  end

  def self.all_tags
    Tag.all.uniq.order(:name).pluck('name')
  end  
end
