class FileAsset < ApplicationRecord
  stampable
  acts_as_taggable
  acts_as_votable
  include EventMessage

  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]

  default_scope { where(tenant_id:Tenant.current_id) if Tenant.current_id }

  has_attached_file :asset, s3_permissions: 'private'

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  attr_accessor :draft_id

  validates :name, presence: true, length: { minimum: 3 }, :if => :require_name? # don't require a name if in draft

  def require_name?
    !draft?
  end

end
