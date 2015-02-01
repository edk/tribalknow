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
      transitions from: [:draft, :submitted, :initial, :failed], to: :completed
    end
  end

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
      ogg: { format: 'ogg' },
      thumb:  { geometry: "300x200", format: 'jpg' },
    }# normally, you would add processors: [:transcoder] to transcode locally
    # instead, we are using a service to do the transcoding for us.

  validates_attachment_content_type :asset, :content_type => /\Avideo\/(ogg|webm|mp4|m4v|quicktime)\Z/
  MAX_FILE_SIZE = 1000.megabytes
  validates_attachment_size :asset, :in => 0.megabytes .. MAX_FILE_SIZE
  scope :published, -> { completed }
  scope :unpublished, -> { 
    va = VideoAsset.arel_table
    where( va[:aasm_state].eq('draft').or(va[:aasm_state].eq('submitted')).or(va[:aasm_state].eq('failed')) )
  }

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

end
