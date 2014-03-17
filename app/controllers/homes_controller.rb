class HomesController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>:index

  def index
    if current_user && Tenant.current_id
      # @activities = PublicActivity::Activity.all
      @activities = PublicActivity::Activity.order("created_at DESC").limit(10)
    else
      render :action => 'public_index'
      return
    end
  end

  def todo
  end

  def about
  end

end
