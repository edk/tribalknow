class SiteStat < ApplicationRecord
  belongs_to :tenant

  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  def self.clear_recent_activity!(keep_last_one: true)
    last = SiteStat.where(name: "recent_activity").last
    if keep_last_one && last
      SiteStat.where(name: "recent_activity").where("id < ?", last.id).destroy_all
    else
      SiteStat.where(name: "recent_activity").destroy_all
    end
  end

  def self.generate_recent_activity! days: 60
    activities = PublicActivity::Activity.where('created_at >= ?', days.days.ago).order("created_at DESC")
    collapsed_activities = activities.inject({}) do |m,o|
      k = "#{o.trackable_type}:#{o.trackable_id}"
      action = o.key.split('.').last  # created, updated, etc
      whodunnit = o.owner&.name
      owner_gid = o.owner&.to_global_id&.to_s
      # todo, add user profiles, and link to the profile of the owner
      if m[k]
        # skip duplicate actions in the activity log.
        if !m[k][:whodunnit].include?({ action: action, who: whodunnit, owner: owner_gid })
          m[k][:whodunnit] << { action: action, who: whodunnit, owner: owner_gid }
        end
      else
        trackable = o.trackable
        # a polymorphic_path would be ideal, but half of these cases are special cases. not much to win from using the "proper" way
        link_desc, link = case trackable
        when Topic
          [trackable.to_s, Rails.application.routes.url_helpers.topic_path(trackable)]
        when Question
          [trackable.to_s, Rails.application.routes.url_helpers.question_path(trackable)]
        when Answer
          [trackable.to_s, Rails.application.routes.url_helpers.question_path(trackable.question)]
        when VideoAsset
          [trackable.name.to_s, Rails.application.routes.url_helpers.video_path(trackable)]
        end
        
        # puts "o.inspect #{o.inspect}"
        # puts "o.trackable.inspect #{o.trackable.inspect}"
        # puts "o.trackable.class #{o.trackable.class}"
        if o.trackable.nil? && o.trackable_type && o.trackable_id
          o.trackable_type.constantize.find(o.trackable_id)
        end
        m[k] = {
          obj: o&.to_global_id.to_s,
          human_name: o.trackable.class.model_name.human,
          trackable: o.trackable&.to_global_id.to_s,
          whodunnit: [{ action: action, who: whodunnit, owner: owner_gid }],
          trackable_desc: link_desc,
          trackable_link: link,
          key: o.key,
          at: o.created_at,
          owner: o.owner&.to_global_id.to_s
        }
      end
      m
    end

    SiteStat.create! name: "recent_activity", data: collapsed_activities
  end

  # a = SiteStat.recent_activity.data
  def self.recent_activity days: 60
    SiteStat.where(name: "recent_activity").last
  end

  def self.clear_top_topics!(keep_last_one: true)
    last = SiteStat.where(name: "top_topics").last
    if keep_last_one && last
      SiteStat.where(name: "top_topics").where("id < ?", last.id).destroy_all
    else
      SiteStat.where(name: "top_topics").destroy_all
    end
  end

  def self.generate_top_topics!
    top_topics = Ahoy::Event.where(name: 'topics#show').top(:properties, 10)
    rv = top_topics.map do |props|
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
    SiteStat.create! name: "top_topics", data: rv
  end

  def self.top_topics
    SiteStat.where(name: "top_topics").last
  end

  def self.clear_top_questions!(keep_last_one: true)
    last = SiteStat.where(name: "top_questions").last
    if keep_last_one && last
      SiteStat.where(name: "top_questions").where("id < ?", last.id).destroy_all
    else
      SiteStat.where(name: "top_questions").destroy_all
    end
  end

  def self.generate_top_questions!
    top_qna = Ahoy::Event.where(name: 'questions#show').top(:properties, 12)
    rv = top_qna.map do |props|
      view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge badge-secondary')
      {
        count: props[1],
        id: props[0]["id"],
        title: Question.friendly.find(props[0]["id"]).title,
        view_count: view_count
      }
    end.compact
    SiteStat.create! name: "top_questions", data: rv
  end

  def self.top_questions
    SiteStat.where(name: "top_questions").last
  end

  def self.clear_top_videos!(keep_last_one: true)
    last = SiteStat.where(name: "top_videos").last
    if keep_last_one && last
      SiteStat.where(name: "top_videos").where("id < ?", last.id).destroy_all
    else
      SiteStat.where(name: "top_videos").destroy_all
    end
  end

  def self.generate_top_videos!
    top_videos = Ahoy::Event.where(name: 'videos#show').top(:properties, 10)
    rv = top_videos.map do |props|
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
    end.reject { |el| [:count, :id, :title].any? { |k| k.nil? } }.compact
    SiteStat.create! name: "top_videos", data: rv
  end

  def self.top_videos
    SiteStat.where(name: "top_videos").last
  end

  def self.clear_top_searches!(keep_last_one: true)
    last = SiteStat.where(name: "top_searches").last
    if keep_last_one && last
      SiteStat.where(name: "top_searches").where("id < ?", last.id).destroy_all
    else
      SiteStat.where(name: "top_searches").destroy_all
    end
  end

  def self.generate_top_searches!
    time_zone = Searchjoy.time_zone || Time.zone
    time_range = 8.weeks.ago.in_time_zone(time_zone).beginning_of_week(:sunday)..Time.now
    searches = Searchjoy::Search.connection.select_all(
      Searchjoy::Search.select("normalized_query, COUNT(*) as searches_count, COUNT(converted_at) as conversions_count, AVG(results_count) as avg_results_count").
      where(created_at: time_range).
      group("normalized_query").
      order("searches_count desc, normalized_query asc").
      limit(20).to_sql).to_a
    top_searches = searches.reject {|el| el['normalized_query'].blank? }.map do |props|
      view_count = ActionController::Base.helpers.content_tag(:span, "#{props['searches_count'].to_i}", class:'badge badge-secondary')
      {
        normalized_query: props['normalized_query'],
        view_count: view_count
      }
    end.compact
    SiteStat.create! name: "top_searches", data: top_searches
  end

  def self.top_searches
    SiteStat.where(name: "top_searches").last
  end

end


