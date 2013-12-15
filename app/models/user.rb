class User < ActiveRecord::Base
  model_stamper
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

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
    self.email.to_s.split('@').first
  end

end
