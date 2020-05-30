module UsersHelper

  def user_theme
    (current_user && current_user.theme) || User::THEMES[5] || User::THEMES.first
  end

end
