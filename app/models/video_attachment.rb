class VideoAttachment < ApplicationRecord
  stampable

  belongs_to :video_asset

  default_scope { where(tenant_id:Tenant.current_id) if Tenant.current_id }

  validates_presence_of :name
  validates :asset, :attachment_presence => true

  has_attached_file :asset, s3_permissions: 'private'
  do_not_validate_attachment_file_type :asset  # upload whatever the heck you want

end

