class TopicFile < ApplicationRecord
  has_attached_file :asset, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :asset, :content_type => [ /\Aimage\/.*\Z/i, /\Aapplication\/.*\Z/i]

  before_post_process :skip_for_non_image_files

  def skip_for_non_image_files
    ! %w[application/zip application/x-zip].include? asset_content_type
  end

  def preview_url
    if image?
      asset.url(:thumb)
    elsif zip?
      ActionController::Base.helpers.image_path("807-package@2x.png")
    else
      ActionController::Base.helpers.image_path("797-archive@2x.png")
    end
  end

  def image?
    asset_content_type =~ %r{^image/}
  end

  def zip?
    asset_content_type =~ %r{^application/.*zip.?}
  end
end
