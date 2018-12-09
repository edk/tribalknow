class RegistrationController < ApplicationController
  skip_before_action :authenticate_user!

  def complete
    if session[:from_omniauth].blank?
      flash[:alert] = "Registration not in process!"
      redirect_to root_path and return
    end

    @user = User.new session[:from_omniauth]
  end

  def update
    if session[:from_omniauth].blank?
      flash[:alert] = "Registration not in process!"
      redirect_to root_path and return
    end

    @user = User.new session[:from_omniauth].merge(:email=>params[:user][:email])

    if @user.save
      from_omniauth = session.delete(:from_omniauth)
      flash[:alert] = "Thank you, an email should be arriving shortly."
      redirect_to root_path
    else
      render :action=>'complete'
    end
  end
end
