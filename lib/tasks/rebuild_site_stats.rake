namespace :site_stats do

  desc "rebuild cache of recent activity and top lists (SiteStat)"
  task :rebuild, [:tenant_id] => [:environment]  do |t, args|
    if args[:tenant_id].nil?
      raise "rake argument 'tenant_id' missing and required.  e.g. `rake site_stats:rebuild[tenant=NNN]`"
    end
    Tenant.current_id = args[:tenant_id].split("=").last.to_i
    SiteStat.clear_recent_activity! keep_last_one: true
    SiteStat.generate_recent_activity!
    puts "SiteStat.where(name: 'recent_activity').count: #{SiteStat.where(name: "recent_activity").count}"
  end

end
