
class ChangeObserver < ActiveRecord::Observer
  observe :topic, :question, :answer

  def after_save(record)
    StaticSiteGeneratorWorker.trigger(Tenant.current.id) if Tenant.current
  end

end
