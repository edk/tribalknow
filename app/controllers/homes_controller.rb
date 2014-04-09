class HomesController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>:index

  def index
    if current_user && Tenant.current_id
      # @activities = PublicActivity::Activity.all
      @activities = PublicActivity::Activity.order("created_at DESC").where('created_at > ?', 20.days.ago).limit(100)
      @collapsed_activities = @activities.inject({}) { |m,o| k="#{o.trackable_type}:#{o.trackable_id}"; m[k] ||= []; m[k] << {:key=>o.key,:at=>o.created_at,:owner=>o.owner, :obj=>o}  ;m }
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
