
# ThinkingSphinx::Index.define :question, :with => :active_record, :delta => true do
#   # fields
#   indexes title, :sortable => true
#   indexes text
#   indexes creator.name, :as=>:creator_name, :sortable => true

#   # attributes
#   has tenant_id, creator_id, updater_id, created_at, updated_at
# end
