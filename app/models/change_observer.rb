
class ChangeObserver < ActiveRecord::Observer
  observe :topic, :question, :answer

  def after_save(record)
    # StaticSiteGenerator.changed!
  end

end
