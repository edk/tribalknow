web: bundle exec puma -C config/puma.rb config.ru
release: bundle exec rake db:migrate && bundle exec rake site:daily[tenant_id=1]
# sidekiq
#
