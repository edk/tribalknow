Tribalknow::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  # config.consider_all_requests_local       = false  # uncomment this to view the rambulance errors in dev mode
  config.action_controller.perform_caching = true

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Prepend all log lines with the following tags.
  config.log_tags = [ :subdomain, :uuid, lambda { |req| "#{req.cookie_jar['_session_id']}" } ]

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  # Add the fonts path
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  # Precompile additional assets
  config.assets.precompile += %w( .svg .eot .woff .ttf )

  # recommended by devise generator
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # to make server logs go to stdout when using unicorn
  # config.logger = Logger.new(STDOUT)
  # config.logger.level = Logger.const_get(
  #   ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].upcase : 'DEBUG'
  # )
end

require Rails.root.join("config/local_config.rb") if File.exist?(Rails.root.join("config/local_config.rb"))

SanitizeEmail::Config.configure do |config|
  config[:sanitized_to] =         ENV['sanitized_to_address']
  config[:sanitized_cc] =         ENV['sanitized_cc_address']
  config[:sanitized_bcc] =        ENV['sanitized_bcc_address']
  # run/call whatever logic should turn sanitize_email on and off in this Proc:
  config[:activation_proc] =      Proc.new { %w(development test).include?(Rails.env) }
  config[:use_actual_email_prepended_to_subject] = true         # or false
  config[:use_actual_environment_prepended_to_subject] = true   # or false
  config[:use_actual_email_as_sanitized_user_name] = true       # or false
end
