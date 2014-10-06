class NotePolicy < Struct.new(:user, :note)
  def permitted_attributes
    if user.admin? || note.try(:creator) == user
      [:title, :content]
    end
  end
end
