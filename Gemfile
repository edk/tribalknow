source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'actioncable'

gem 'activerecord-session_store'
gem 'haml-rails'
gem 'jbuilder'
gem 'sidekiq'
# gem 'sinatra', :require => nil # for the sidekiq web ui
gem 'google-analytics-rails'
gem 'redis'
gem 'redis-rails'
gem 'rollout'
gem 'rollbar' # exception service
gem 'oj'

gem 'pg'
gem 'pg_search'
gem 'devise'
gem 'omniauth-github'
gem "octokit"
gem "pundit"
gem 'paperclip'
gem 'paperclip-av-transcoder'
gem 'aws-sdk-s3'
gem 'certified'
gem 'aasm'
gem 'rails-observers'
gem 'awesome_nested_set'
gem 'ahoy_matey'
gem 'groupdate'
gem 'chartkick'
gem 'hightop'
gem 'searchjoy'

gem 'acts-as-taggable-on'
gem 'userstamp', github: 'kimkong/userstamp', branch: 'fix-for-rails-4-2'
gem 'paper_trail'
gem 'diffy'
gem 'public_activity'
gem 'acts_as_votable'
# gem 'merit'
gem "interactor-rails"#, "~> 2.0"

gem 'newrelic_rpm'
gem 'exception_notification'

gem 'github-markdown'
gem 'html_truncator'

gem 'will_paginate'
gem 'best_in_place', github: 'edk/best_in_place'
gem 'render_anywhere', :require => false

gem 'select2-rails'
gem 'underscore-rails'
gem 'ledermann-rails-settings', :require => 'rails-settings'
gem 'jquery-ui-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'friendly_id'

gem 'simple_form'
gem 'nokogiri'
gem 'faraday'
gem 'dotenv-rails'
gem 'dotenv-deployment'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'sanitize_email'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'seed_dump'
  #gem 'protected_attributes' # only to get seed_dump to work
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'factory_bot_rails'
  gem 'faker'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'webdriver'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'tzinfo-data'
