class User < ActiveRecord::Base
  model_stamper

  has_settings :preference

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :validatable, :trackable,
         :omniauthable, :omniauth_providers => [:github]

  belongs_to :tenant
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }

  has_many :topics, foreign_key: :creator_id
  has_many :questions, foreign_key: :creator_id
  has_many :answers, foreign_key: :creator_id

  scope :admins, -> { where(:admin=>true) }
  scope :active, -> { where(:active=>true) }

  scope :with_tenant, -> (tenant) { where(:tenant_id => tenant.id) }
  def using_tenant &block
    self.class.where(:tenant_id=>tenant_id).instance_eval &block
  end

  after_create :send_admin_email
  def send_admin_email
    if requires_admin_approval?
      AdminMailer.new_user_waiting_for_approval(self).deliver
    else
      approve_and_activate_send_email!
    end
  end

  def requires_admin_approval?
    self.tenant && self.tenant.email_domain_requires_approval?(self.email)
  end

  def approve_and_activate_send_email!
    self.update_columns(approved: true, active: true)
    self.send_confirmation_instructions
  end

  def from_external_auth?
    if %w[provider uid name].all? {|attr| self.send(attr).present? }
      return true
    end
    false
  end

  def password_required?
    super if !from_external_auth?
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
        # create from scratch
        user = User.create!(:provider=>auth.provider, :uid=>auth.uid, :name=>auth.info.nickname,
                            :email=>auth.info.email)
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

  def confirmation_required?
    false
  end

  def active_for_authentication?
    if tenant && tenant.new_user_restriction?
      super && approved? && (confirmed? || confirmation_period_valid?)
    else
      super && approved? && (confirmed? || confirmation_period_valid?)
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

end
