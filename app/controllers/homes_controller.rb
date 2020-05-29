class HomesController < ApplicationController
  skip_before_action :authenticate_user!, :only=>:index

  def index
    if current_user && Tenant.current_id
      @top = {}

      @collapsed_activities = SiteStat.recent_activity
      @collapsed_activities = @collapsed_activities && @collapsed_activities.data

      @top[:topics] = SiteStat.top_topics
      @top[:topics] = @top[:topics] && @top[:topics].data

      @top[:qna] = SiteStat.top_questions
      @top[:qna] = @top[:qna] && @top[:qna].data

      @top[:videos] = SiteStat.top_videos
      @top[:videos] = @top[:videos] && @top[:videos].data

      @top[:searches] = SiteStat.top_searches
      @top[:searches] = @top[:searches] && @top[:searches].data

      # @popular_questions = Question.popular
    else
      if (landing_page = Tenant.current.try(:landing_page)).present?
        render :text => landing_page, :layout=>true
      else
        redirect_to new_user_session_path
      end

      return
    end
  end

end
