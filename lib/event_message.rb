
module EventMessage

  def event_message user = nil, context = :create, url = nil
    classname = self.class.to_s.downcase
    verb = self.respond_to?(:class_as_verb) && self.class_as_verb || "created #{classname}"

    user = user.hipchat_mention_name.presence || user.to_s

    topic = if url
      %Q|<a href="#{url}">#{self.to_s}</a>|
    else
      self.to_s
    end

    case context
      when :create
        "#{user} #{verb}: #{topic}"
      when :update
        "#{user} updated the #{classname}: #{topic}"
      when :destroy
        "#{user} deleted the #{classname}: #{topic}"
      else
        "#{user} updated the #{classname}: #{topic}"
    end
  end
end
