class HomesController < ApplicationController
  skip_before_action :authenticate_user!, :only=>:index

  def index
    if current_user && Tenant.current_id
      @top = {}

      @top[:topics] = Ahoy::Event.where(name: 'topics#show').top(:properties, 10)
      cache_key = [ 'top_topics', @top[:topics].map{ |k,v| v } ]
      @top[:topics] = Rails.cache.fetch(cache_key) do
        @top[:topics].map do |props|
          begin
            topic = Topic.friendly.find(props[0]["id"])
            string =  ActionController::Base.helpers.sanitize([topic.name, topic.description].reject(&:blank?).join(' - '))
            view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge badge-secondary')
            {
              count: props[1],
              id: props[0]["id"],
              title: string,
              view_count: view_count
            }
          rescue
            nil
          end
        end.compact
      end

      @top[:qna] = Ahoy::Event.where(name: 'questions#show').top(:properties, 12)
      cache_key = [ 'top_qna', @top[:qna].map{ |k,v| v } ]
      @top[:qna] = Rails.cache.fetch(cache_key) do
        @top[:qna].map do |props|
          view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge badge-secondary')
          {
            count: props[1],
            id: props[0]["id"],
            title: Question.friendly.find(props[0]["id"]).title,
            view_count: view_count
          }
        end
      end

      @top[:videos] = Ahoy::Event.where(name: 'videos#show').top(:properties, 10)
      cache_key = [ 'top_videos', @top[:videos].map{ |k,v| v } ]
      @top[:videos] = Rails.cache.fetch(cache_key) do
        @top[:videos].map do |props|
          view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge badge-secondary')
          title = VideoAsset.friendly.find(props[0]["id"]).name rescue ""
          video_id = props[0]["id"] rescue nil
          count = props[1] rescue nil
          {
            count: count,
            id: video_id,
            title: title,
            view_count: view_count
          }
        end.reject { |el| [:count, :id, :title].any? { |k| k.nil? } }
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
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props['searches_count'].to_i}", class:'badge badge-secondary')
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
