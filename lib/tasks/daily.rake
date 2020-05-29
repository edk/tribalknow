namespace :site do
  desc "daily site tasks"
  task :daily, [:tenant_id] => [:environment]  do |t, args|
    if args[:tenant_id].nil?
      raise "rake argument 'tenant_id' missing and required.  e.g. `rake site_stats:rebuild[tenant=NNN]`"
    end
    # note args[:tenant_id] looks like "tenant_id=123" not just the value.
    Rake::Task["pg_search:rebuild_all"].invoke
    Rake::Task["site_stats:rebuild"].invoke(args[:tenant_id])
  end

end
