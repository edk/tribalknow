class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user && user.persisted?
      sign_in_and_redirect user, notice: 'signed in!'
    else
      if !user && session.has_key?(:from_omniauth)
        redirect_to registration_complete_path
      else
        redirect_to new_user_registration_path
      end
    end
  end
end
