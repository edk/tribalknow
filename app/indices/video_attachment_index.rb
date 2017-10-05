
ThinkingSphinx::Index.define :video_attachment, :with => :active_record, :delta => true do
  # fields
  indexes name, :sortable => true
  indexes description
  indexes asset_file_name
  indexes creator.name, :as=>:creator_name, :sortable => true

  # attributes
  has tenant_id, creator_id, updater_id, created_at, updated_at
end
