
module EventMessage
  def event_message user = nil, context = :create
    classname = self.class.to_s.downcase
    verb = self.respond_to?(:class_as_verb) && self.class_as_verb || "created #{classname}"

    case context
      when :create
        "#{user} #{verb}: #{self}"
      when :update
        "#{user} updated the #{classname}: #{self}"
      when :destroy
        "#{user} deleted the #{classname}: #{self}"
      else
        "#{user} updated the #{classname}: #{self}"
    end
  end
end
