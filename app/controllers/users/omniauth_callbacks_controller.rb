class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.from_omniauth(request.env["omniauth.auth"])
    
    if user && !user.active?
      Rails.logger.error("DBG omniauth_callbacks_controller.rb: #{__LINE__} !user.active? => true")
      ahoy.track("omniauth-login-failed", {id: user.id, name: user.name, email: user.email, provider: user.provider, errors: user.errors.full_messages.join(', ')})
      Rails.logger.error("DBG omniauth_callbacks_controller.rb: #{__LINE__} user.errors.full_messages: #{user.errors.full_messages.join(' : ') rescue $!}")
      redirect_to new_user_session_path, notice: user.errors.full_messages.join("<br/>").html_safe
    elsif user && user.persisted?
      ahoy.track("omniauth-login-ok", {id: user.id, name: user.name, email: user.email, provider: user.provider})
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
