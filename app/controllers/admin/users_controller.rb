class Admin::UsersController < Admin::HomeController
  def index
    @users = User.paginate(:page=>params[:page])
    authorize @users
  end
end
