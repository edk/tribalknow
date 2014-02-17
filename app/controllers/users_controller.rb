class UsersController < ApplicationController
  def index
    @users = User.paginate(:page=>params[:page])
    authorize @users
  end
end
