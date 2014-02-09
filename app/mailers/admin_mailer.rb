class AdminMailer < ActionMailer::Base
  default from: "system@tribalknownow.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.new_user_waiting_for_approval.subject
  #
  def new_user_waiting_for_approval user
    mail to: "eddyhkim@gmail.com"
  end
end
