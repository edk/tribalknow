
class UserPolicy
  attr_accessor :user, :user_resource

  def initialize user, user_resource
    @user, @user_resource = user, user_resource
  end

  def index?
    @user.admin?
  end

  def update?
    @user.admin?
  end

end
