
class ChangeObserver < ActiveRecord::Observer
  observe :topic, :question, :answer

  def after_save(record)
    begin
      StaticSiteGeneratorWorker.trigger(Tenant.current.id) if Tenant.current
    rescue Redis::CannotConnectError
      Rails.logger.debug "Redis is down, can't rebuild static version of site"
    end
  end

end
