source 'https://rubygems.org'

gem 'rails', '~> 5.2'
gem 'puma'
# gem 'sprockets-es6'
gem 'activerecord-session_store'
gem 'haml-rails'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
gem 'jbuilder'
gem 'sidekiq'
gem 'sinatra', :require => nil # for the sidekiq web ui
gem 'google-analytics-rails'
gem 'redis'
gem 'redis-rails'
gem 'rollout'
gem 'rollbar' # exception service
gem 'oj'

gem 'mysql2'
gem 'sqlite3', require: false
gem 'devise'
gem 'omniauth-github'
gem "octokit"
gem "pundit"
gem 'paperclip'
gem 'paperclip-av-transcoder'
gem 'aws-sdk'
gem 'hipchat'
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

gem 'thinking-sphinx'#, '~> 3.1'

gem 'jquery-rails' # use version  '2.0.2' to specifically use jquery 1.7.2 (for select2)
gem 'select2-rails'
gem 'underscore-rails'
gem 'ledermann-rails-settings', :require => 'rails-settings'
gem 'jquery-ui-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'friendly_id'

gem 'simple_form'
gem 'sass-rails'#, '~> 4.0.0.rc2'
gem 'uglifier'#, '>= 1.3.0'
gem 'nokogiri'
gem 'faraday'
gem 'dotenv-rails'
gem 'dotenv-deployment'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem "airbrussh", require: false
  gem 'capistrano'#, '~> 3.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'guard-livereload', require: false
  gem 'sanitize_email'
end

group :development, :test do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'pry'
  gem 'byebug'
  gem 'seed_dump'
  #gem 'protected_attributes' # only to get seed_dump to work
  gem 'rspec-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'tzinfo-data'
