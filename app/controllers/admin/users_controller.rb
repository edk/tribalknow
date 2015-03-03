class Admin::UsersController < Admin::HomeController
  def index
    @users = User.order('id desc').paginate(:page=>params[:page])
    authorize @users
  end
end
