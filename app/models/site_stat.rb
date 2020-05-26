class SiteStat < ApplicationRecord
  belongs_to :tenant

  def self.generate_recent_activity! days: 30
    activities = PublicActivity::Activity.where('created_at >= ?', days.days.ago).order("created_at DESC")
    collapsed_activities = activities.inject({}) do |m,o|
      k = "#{o.trackable_type}:#{o.trackable_id}"
      m[k] ||= []
      m[k] << {:key=>o.key,:at=>o.created_at,:owner=>o.owner, :obj=>o}
      m
    end

    []
  end

  def self.recent_activity days: 30
    []
  end

  def self.top_topics
  end
end
