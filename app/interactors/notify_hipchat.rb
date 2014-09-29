require 'hipchat'

class NotifyHipchat
  include Interactor

  def call
    return unless self.class.hipchat_configured?

    msg = context.object.event_message context.user, context.type, context.url
    begin
      send_message msg
    rescue
      Rails.logger.error("There was a failure sending the notification to hipchat")
      # TODO: add a background job system to retry in the future.
    end
  end

  def send_message msg
    if Rails.env.production?
      hipchat_client[AppConfig['hipchat_room_id']].send(AppConfig['hipchat_from_user'], msg)
    else
      puts "\n Would have sent Hipchat message: #{msg}"
    end
  end

  def hipchat_client
    @api_ver ||= AppConfig['hipchat_api_version'].presence || 'v1'
    @client  ||= HipChat::Client.new(AppConfig['hipchat_api_key'], :api_version=>@api_ver)
  end


  def self.hipchat_configured?
    AppConfig.where('key'=>%w[hipchat_api_key hipchat_room_id hipchat_from_user]).count == 3
  end
end
