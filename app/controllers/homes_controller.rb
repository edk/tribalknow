class HomesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
      # @activities = PublicActivity::Activity.all
      @activities = PublicActivity::Activity.order("created_at DESC")

  end

  def todo
  end

end
