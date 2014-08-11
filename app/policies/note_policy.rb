class NotePolicy < Struct.new(:user, :note)
  def permitted_attributes
    if user.admin? || user.owner_of?(note)
      [:title, :content]
    end
  end
end
