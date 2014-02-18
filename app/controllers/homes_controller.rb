class HomesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user && Tenant.current_id
      # @activities = PublicActivity::Activity.all
      @activities = PublicActivity::Activity.order("created_at DESC").limit(20)
    else
      render :action => 'public_index'
      return
    end
  end

  def todo
  end

end
