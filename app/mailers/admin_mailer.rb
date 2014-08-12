class AdminMailer < ActionMailer::Base
  default from: "system@tribalknownow.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.new_user_waiting_for_approval.subject
  #
  def new_user_waiting_for_approval user
    users = User.active.with_tenant(user.tenant).where(:admin=>true)
    if users.empty? && User.active.with_tenant(user.tenant).count != 0
      raise "no admin users found"
    end

    @user = user
    mail(to: users.map(&:email), :from=>"system@#{Tenant.current.fqdn}") unless users.empty?
  end

  def user_account_rejected user
    mail to: user.email
  end
end
