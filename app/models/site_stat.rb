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

  def self.generate_recent_activity! days: 30
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

    SiteStat.create! name: "recent_activity",
                    data: collapsed_activities
  end

  def self.recent_activity days: 30
    SiteStat.where(name: "recent_activity").last
  end

  def self.top_topics
  end
end


