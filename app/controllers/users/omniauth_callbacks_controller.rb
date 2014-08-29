class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.from_omniauth(request.env["omniauth.auth"])
    Rails.logger.error("XXX debug only: request.env['omniauth.auth'] = #{request.env["omniauth.auth"].inspect})"
    if user.persisted?
      sign_in_and_redirect user, notice: 'signed in!'
    else
      redirect_to new_user_registration_path
    end
  end
end
