
class Paperclip::MediaTypeSpoofDetector
  def spoofed?
    if File.extname(@name) =~ /webm\Z/
      # Paperclip::MediaTypeSpoofDetector uses the 'file' utility to try to determine
      # the content type of the file.  For webm, the result is the useless 
      # 'application/octect-stream' so skip checking for webm.
      false
    elsif has_name? && has_extension? && media_type_mismatch? && mapping_override_mismatch?
      Paperclip.log("Content Type Spoof: Filename #{File.basename(@name)} (#{supplied_file_content_types}), content type discovered from file command: #{calculated_content_type}. See documentation to allow this combination.")
      true
    end
  end
end

class VideoAsset < FileAsset

  has_many :transcode_jobs, class_name: 'TranscodeRemote', dependent: :destroy

  include AASM
  aasm do
    state :draft, initial: true
    state :submitted
    state :failed
    state :completed

    event :submit do
      transitions from: [:draft, :submitted, :failed], to: :submitted, guard: Proc.new {
        tj = transcode_jobs.build
        rv = tj.queue_new_job
        tj.save
        rv # the return value of the guard determines if we drop down to the next transition
      }
      transitions from: [:draft, :submitted, :failed, :completed], to: :failed
    end
    event :fail do
      transitions from: [:draft, :submitted, :initial, :failed], to: :failed
    end
    event :complete do
      transitions from: [:draft, :submitted, :initial, :failed, :completed], to: :completed
    end
  end

  has_many :video_attachments

  has_attached_file :thumbnail,
    storage: :s3,
    s3_permissions: 'private',
    styles: { thumb: '300x200', format: 'jpg' }

  has_attached_file :asset,
    storage: :s3,
    s3_permissions: 'private',
    s3_credentials: Proc.new { |a| a.instance.s3_credentials },
    styles: {
      mp4: { format: 'mp4' },
      ogg: { format: 'webm' },
      thumb:  { geometry: "300x200", format: 'jpg' },
    }# normally, you would add processors: [:transcoder] to transcode locally
    # instead, we are using a service to do the transcoding for us.

  # do_not_validate_attachment_file_type :asset
  validates_attachment_file_name :asset, :matches => [/m4v\Z/, /mp4\Z/, /mov\Z/, /webm\Z/, /avi\Z/]

  MAX_FILE_SIZE = 1000.megabytes
  validates_attachment_size :asset, :in => 0.megabytes .. MAX_FILE_SIZE
  scope :published, -> { completed }
  scope :unpublished, -> { 
    va = VideoAsset.arel_table
    where( va[:aasm_state].eq('draft').or(va[:aasm_state].eq('submitted')).or(va[:aasm_state].eq('failed')) )
  }
  scope :by_most_recent_first, -> { order('updated_at desc') }

  has_one :secret, class_name: 'VideoAccessSecret', dependent: :destroy
  after_initialize :init_values

  def init_values
    self.create_secret if !secret
  end

  before_post_process :do_local_processing?

  def do_local_processing?
    false # never do local processing in this app.  Use the remote transcoding service (See TranscodeRemote)
  end

  def check_status!
    tj = transcode_jobs.build
    rv = tj.query_job_status
    tj.save!
    rv
  end

  def friendly_state
    submitted? ? "processing" : aasm_state
  end

  def expiring_download_url options = {}
    s3 = AWS::S3.new
    s3_videos_bucket = s3_credentials[:bucket]
    bucket = s3.buckets[s3_videos_bucket]
    style = options[:style] || :mp4
    object_path = asset.path(style).sub(/^\//,'') # strip the leading /
    object = bucket.objects[object_path]
    expires = options[:expires] || 60.minutes

    object.url_for(:get, { 
      expires: expires,
      response_content_disposition: 'attachment;'
    }).to_s
  end

  def s3_credentials
    unless %w[S3_BUCKET S3_ACCESS_KEY S3_SECRET].all? { |key| ENV[key].present? }
      raise "Missing S3 Environment variables" 
    end

    {
      bucket: ENV['S3_BUCKET'],
      access_key_id: ENV['S3_ACCESS_KEY'],
      secret_access_key: ENV['S3_SECRET']
    }
  end

  def self.without_public_activity
    begin
      VideoAsset.public_activity_off
      yield
    ensure
      VideoAsset.public_activity_on
    end
  end

end
