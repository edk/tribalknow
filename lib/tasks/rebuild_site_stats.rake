namespace :site_stats do

  desc "rebuild cache of recent activity and top lists (SiteStat)"
  task :rebuild, [:tenant_id] => [:environment]  do |t, args|
    if args[:tenant_id].nil?
      raise "rake argument 'tenant_id' missing and required.  e.g. `rake site_stats:rebuild[tenant=NNN]`"
    end
    Tenant.current_id = args[:tenant_id].split("=").last.to_i

    SiteStat.clear_recent_activity! keep_last_one: true
    SiteStat.generate_recent_activity!

    SiteStat.clear_top_topics!
    SiteStat.generate_top_topics!

    SiteStat.clear_top_questions!
    SiteStat.generate_top_questions!

    SiteStat.clear_top_videos!
    SiteStat.generate_top_videos!

    SiteStat.clear_top_searches!
    SiteStat.generate_top_searches!
    %w[top_searches top_videos top_questions top_topics recent_activity].each do |name|
      puts "SiteStat.where(name: '#{name}').count: #{SiteStat.where(name: name).count} ids: #{SiteStat.where(name: name).pluck(:id)}"
    end
  end

end
