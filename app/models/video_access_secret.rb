class VideoAccessSecret < ApplicationRecord
  belongs_to :video_asset

  after_initialize :secret_init

  def secret_init
    self.value ||= SecureRandom.hex
  end

end
