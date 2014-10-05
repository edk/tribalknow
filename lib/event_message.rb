
module EventMessage

  def event_message user = nil, context = :create, url = nil, again = nil
    classname = self.class.to_s.downcase
    verb = self.respond_to?(:class_as_verb) && self.class_as_verb || "created #{classname}"

    user = user.hipchat_mention_name.presence || user.to_s

    topic = if url
      %Q|<a href="#{url}">#{self.to_s}</a>|
    else
      self.to_s
    end

    if again
      again = ["#{user} wants to know more about", "Can anyone answer", "Does anyone know"].sample
      question = "?"
      user  = verb = ""
    else
      again = ""
    end

    case context
      when :create
        "#{[again, user, verb].join(" ").strip}: #{topic}#{question}"
      when :update
        "#{user} updated the #{classname}: #{topic}"
      when :destroy
        "#{user} deleted the #{classname}: #{topic}"
      else
        "#{user} updated the #{classname}: #{topic}"
    end
  end
end
