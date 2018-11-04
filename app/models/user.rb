class User < ApplicationRecord
  model_stamper
  acts_as_voter

  has_settings :preference

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :trackable,
         :confirmable, :omniauthable, :omniauth_providers => [:github]

  belongs_to :tenant
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  has_attached_file :avatar, :styles => { :thumb => "80x80#" }, :default_url => "blank-icon-80x80.gif"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :visits
  has_many :topics, foreign_key: :creator_id
  has_many :questions, foreign_key: :creator_id
  has_many :answers, foreign_key: :creator_id

  has_many :user_notifications, -> { where read: false }
  has_many :notifications, :through=>:user_notifications

  scope :admins, -> { where(:admin=>true) }
  scope :active, -> { where(:active=>true) }

  scope :with_tenant, -> (tenant) { where(:tenant_id => tenant.id) }
  def using_tenant &block
    self.class.where(:tenant_id=>tenant_id).instance_eval &block
  end

  before_create :fake_confirmation_if_necessary
  def fake_confirmation_if_necessary
    if AppConfig['disable_confirmation'].to_i == 1
      self.confirmed_at = Time.now
    end
  end

  after_create :send_admin_email
  def send_admin_email
    if requires_admin_approval?
      AdminMailer.new_user_waiting_for_approval(self).deliver
    else
      approve_and_activate_send_email!
    end
  end

  before_save :normalize_hipchat

  def normalize_hipchat
    if hipchat_mention_name.present? && hipchat_mention_name !~ /^@/
      hipchat_mention_name = "@#{hipchat_mention_name}"
    end
  end

  def requires_admin_approval?
    return false if skip_activation?
    tenant && tenant.email_domain_requires_approval?(email)
  end

  def approve_and_activate_send_email!
    self.update_columns(approved: true, active: true)
    if self.respond_to?(:send_confirmation_instructions) && !(AppConfig['disable_confirmation'].to_i == 1 || skip_confirmation?)
      send_confirmation_instructions
    else
      AdminMailer.you_are_approved(self).deliver
    end
  end

  def from_external_auth?
    %w[provider uid name].all? {|attr| self.send(attr).present? }
  end

  # All this extra machinery is to allow github authentication without a password,
  # but optionally allow it, and require passwords if the user is not externally authenticated.
  attr_accessor :changing_password
  def password_required?
    super if !from_external_auth? || changing_password
  end


  # def password_match?
  #   self.errors[:password] << "can't be blank" if password.blank?
  #   self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
  #   self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
  #   password == password_confirmation && !password.blank?
  # end

  def self.from_omniauth auth
    user = User.where(:provider=>auth.provider, :uid=>auth.uid).first

    if !user
      # if not in our system with github authentication, need to either create a new
      # user, or find an existing user with matching email
      if user = User.where(:email=>auth.info.email).first
        # update existing user record with additional github info
        user.name = auth.info.nickname
        user.provider, user.uid, user.avatar_url = auth.provider, auth.uid, auth.info.image
        user.save(:validate=>false)
      else

        fields = {
          provider: auth.provider, uid: auth.uid, name: auth.info.nickname, email: auth.info.email,
        }
        # create from scratch
        if auth.info.email.blank?
          # no email?  That's unfortunate.  Let's ask them what it is.
          session[:from_omniauth] = fields
        else
          if github_org_required? && is_org_member?(auth['credentials']['token'])
            Rails.logger.error("DBG: #{__LINE__} fields => #{fields.inspect}  probably need to add active: true to this hash")
            fields.merge!({skip_confirmation: true, skip_activation: true, active: true})
          end
          user = User.create!(fields)
          Rails.logger.error("DBG: user.active => #{user.active}")
          user
        end
      end
    end

    if user && github_org_required?
      if !is_org_member?(auth['credentials']['token'])
        user.disable_unauthorized!(user.tenant.github_auth_failure_message)
      end
    end

    user
  end

  def name
    # use email for now, or github login when available
    self.attributes["name"].presence || self.email.to_s.split('@').first
  end

  def to_s
    name
  end

  def self.allow_unconfirmed_access_for
    7.days
  end

  def active_for_authentication?
    if tenant && tenant.new_user_restriction?
      super && approved? && (respond_to?(:confirmed?) && (confirmed? || confirmation_period_valid?))
    else
      super && approved? && (respond_to?(:confirmed?) && (confirmed? || confirmation_period_valid?))
    end
  end

  def inactive_message
    if tenant && tenant.new_user_restriction?
      approved? ? super : :not_approved
    else
      super
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def disable_unauthorized! msg=nil
    self.update_attribute :active, false
    self.errors.add(:base, "Sorry this user is not authorized to access this site. #{msg}")
  end

  def self.github_org_required?
    tenant = Tenant.current
    tenant && tenant.required_github_organization.present?
  end

  def self.is_org_member? access_token
    tenant = Tenant.current
    client = Octokit::Client.new access_token: access_token
    tenant.required_github_organization.to_s.split(',').map(&:strip).any? do |org|
      client.org_member?(org, client.user.login)
    end
  end

end
