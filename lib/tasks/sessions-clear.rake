
desc "Clear expired sessions"
task :clear_expired_sessions => :environment do
  rv = ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 3.weeks.ago])
  puts "Deleted #{rv} sessions"
end

