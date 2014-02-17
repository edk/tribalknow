class ApproveUsersController < ApplicationController
  def index
    @users = User.where(:approved=>false)
    authorize @users
  end

  def approve
    user = User.find(params[:id]) # default scope shoudl still restrict to current tenant
    authorize user, :update?
    user.approved = true
    user.active = true
    user.save!
    user.send_confirmation_instructions
    flash[:notice] = "Successfully approved user."
    redirect_to :action=>'index'
  end

  def reject
    user = User.find(params[:id]) # default scope shoudl still restrict to current tenant
    authorize user, :update?
    if user # actually find should throw if not found.
      AdminMailer.user_account_rejected(user).deliver
      user.destroy!
    end
    flash[:notice] = "Successfully rejected and deleted user account."
    redirect_to :action=>'index'
  end
end
