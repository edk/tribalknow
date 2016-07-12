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
        {
          count: props[1],
          id: props[0]["id"],
          title: (topic = Topic.friendly.find(props[0]["id"])).title.presence || topic.name,
        }
      end

      @top[:qna] = Ahoy::Event.where(name: 'questions#show').limit(10).top(:properties)
      @top[:qna] = @top[:qna].map do |props|
        {
          count: props[1],
          id: props[0]["id"],
          title: Question.friendly.find(props[0]["id"]).title,
        }
      end

      @top[:videos] =Ahoy::Event.where(name: 'videos#show').limit(10).top(:properties)
      @top[:videos] = @top[:videos].map do |props|
        {
          count: props[1],
          id: props[0]["id"],
          title: VideoAsset.friendly.find(props[0]["id"]).name,
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
      
      @top[:searches] = @searches


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
