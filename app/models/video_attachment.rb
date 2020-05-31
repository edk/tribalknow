class VideoAttachment < ApplicationRecord
  stampable

  belongs_to :video_asset

  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  validates_presence_of :name
  validates :asset, :attachment_presence => true

  has_attached_file :asset, s3_permissions: 'private',
                    s3_credentials: Proc.new { |a| a.instance.s3_credentials },
                    s3_url_options: { response_content_disposition: 'attachment;' }

  do_not_validate_attachment_file_type :asset  # upload whatever the heck you want

  def s3_credentials(version: nil)
    required_vars = %w[S3_BUCKET S3_ACCESS_KEY S3_SECRET S3_REGION]
    unless required_vars.all? { |key| ENV[key].present? }
      raise "Missing S3 Environment variables: #{%w[S3_BUCKET S3_ACCESS_KEY S3_SECRET S3_REGION].select {|v| ENV[v].blank? }.compact.inspect }"
    end
    case version
    when 2
      {
        credentials: {
          access_key_id: ENV['S3_ACCESS_KEY'], secret_access_key: ENV['S3_SECRET'],
        },
        # bucket: ENV['S3_BUCKET'],
        region: ENV['S3_REGION']
      }
    else
      {
        access_key_id: ENV['S3_ACCESS_KEY'], secret_access_key: ENV['S3_SECRET'],
        bucket: ENV['S3_BUCKET'],
        s3_region: ENV['S3_REGION']
      }
    end
  end

end
