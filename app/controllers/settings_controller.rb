class SettingsController < ApplicationController

  def update
    current_user.settings(:preference).update_attributes!( params[:id] => (params[:value] || Time.now.utc) )
    respond_to do |format|
      format.js {
        render :js => ""
      }
    end
  end

end
