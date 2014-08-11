
ThinkingSphinx::Index.define :note, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes content
  indexes creator.name, :as=>:creator_name, :sortable => true

  # attributes
  has creator_id, updater_id, created_at, updated_at
end
