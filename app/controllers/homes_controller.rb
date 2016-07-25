class HomesController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>:index

  def index
    if current_user && Tenant.current_id
      # @activities = PublicActivity::Activity.all
      @activities = PublicActivity::Activity.order("created_at DESC").where('created_at > ?', 30.days.ago).limit(50)
      @collapsed_activities = @activities.inject({}) do |m,o|
        k = "#{o.trackable_type}:#{o.trackable_id}"
        m[k] ||= []
        m[k] << {:key=>o.key,:at=>o.created_at,:owner=>o.owner, :obj=>o}
        m
      end

      @top = {}

      @top[:topics] = Ahoy::Event.where(name: 'topics#show').limit(10).top(:properties)
      @top[:topics] = @top[:topics].map do |props|
        topic = Topic.friendly.find(props[0]["id"])
        string =  ActionController::Base.helpers.sanitize([topic.name, topic.description].reject(&:blank?).join(' - '))
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge-count')
        {
          count: props[1],
          id: props[0]["id"],
          title: string,
          view_count: view_count
        }
      end

      @top[:qna] = Ahoy::Event.where(name: 'questions#show').limit(12).top(:properties)
      @top[:qna] = @top[:qna].map do |props|
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge-count')
        {
          count: props[1],
          id: props[0]["id"],
          title: Question.friendly.find(props[0]["id"]).title,
          view_count: view_count
        }
      end

      @top[:videos] =Ahoy::Event.where(name: 'videos#show').limit(10).top(:properties)
      @top[:videos] = @top[:videos].map do |props|
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge-count')
        {
          count: props[1],
          id: props[0]["id"],
          title: VideoAsset.friendly.find(props[0]["id"]).name,
          view_count: view_count
        }
      end

      @time_zone = Searchjoy.time_zone || Time.zone
      @time_range = 8.weeks.ago.in_time_zone(@time_zone).beginning_of_week(:sunday)..Time.now
      @searches = Searchjoy::Search.connection.select_all(
        Searchjoy::Search.select("normalized_query, COUNT(*) as searches_count, COUNT(converted_at) as conversions_count, AVG(results_count) as avg_results_count").
        where(created_at: @time_range).
        group("normalized_query").
        order("searches_count desc, normalized_query asc").
        limit(20).to_sql).to_a
      
      @top[:searches] = @searches.reject {|el| el['normalized_query'].blank? }.map do |props|
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props['searches_count'].to_i}", class:'badge-count')
        {
          normalized_query: props['normalized_query'],
          view_count: view_count
        }
      end


      @popular_questions = Question.popular
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
