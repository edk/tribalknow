class AdminMailer < ActionMailer::Base
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.new_user_waiting_for_approval.subject
  #
  def new_user_waiting_for_approval user
    recipients = User.active.with_tenant(user.tenant).where(:admin=>true)
    if recipients.empty? && User.active.with_tenant(user.tenant).count != 0
      raise "no admin users found"
    end

    proto = Rails.env.production? ? 'https' : 'http'
    tenant = user.tenant
    @url  = "#{proto}://#{tenant.fqdn}/#{admin_approve_users_path}"
    @user = user
    mail(to: recipients.map(&:email), :from=>"system@#{Tenant.current.fqdn}") unless recipients.empty?
  end

  def user_account_rejected user
    mail to: user.email
  end

  def you_are_approved user
    @user = user
    @tenant = user.tenant
    mail to: @user.email, subject: "Your account has been approved on #{@tenant.fqdn}"
  end

end
