class PublicProfilesController < ApplicationController

  def index
    @public_profiles = User.all
    
  end

  def show
    @public_profile = User.find(params[:id])


  end

end
