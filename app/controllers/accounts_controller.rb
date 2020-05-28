class AccountsController < ApplicationController
  include ApplicationHelper
  
  def show
    @user = current_user
  end
  
  def update
    @user = current_user
    if params[:user][:password].present?
      @user.changing_password = true
    else
      [:password, :password_confirmation].each { |key| params[:user].delete(key) }
    end

    if @user.update_attributes(user_params)
      if params[:user][:password].present? && params[:user][:password_confirmation] == params[:user][:password]
        sign_in @user, :bypass => true # needed by devise.
      end
      redirect_to :action => 'show'
    else
      render :action=>:show
    end
  end

  def avatar
    @user = current_user
    if params[:reset].present?
      @user.avatar.destroy
      @user.save(:validate=>false)
    else
      @user.avatar = params[:file]
    end

    respond_to do |format|
      format.json {
        resp = {}
        if @user.avatar?
          resp[:url] = @user.avatar.url(:thumb)
          resp[:user_avatar] = true
        else
          resp[:url] = gravitar_url(@user)
          resp[:user_avatar] = false
        end

        if @user.save
          render :json => resp
        else
          @user.reload
          render :json => resp, status: 500
        end
      }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :theme)
  end

end
