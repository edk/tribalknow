require 'hipchat'

class NotifyHipchat
  include Interactor

  def call
    return unless hipchat_configured?

    msg = context.object.event_message context.user, context.type
    hipchat_client[AppConfig['hipchat_room_id']].send(AppConfig['hipchat_from_user'], msg)
  end

  def hipchat_client
    @api_ver ||= AppConfig['hipchat_api_version'].presence || 'v1'
    @client  ||= HipChat::Client.new(AppConfig['hipchat_api_key'], :api_version=>@api_ver)
  end


  def hipchat_configured?
    AppConfig.where('key'=>%w[hipchat_api_key hipchat_room_id hipchat_from_user]).count == 3
  end
end
