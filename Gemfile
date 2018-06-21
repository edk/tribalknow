source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'activerecord-session_store'
gem 'haml-rails'
gem 'jbuilder', '~> 1.2'
gem 'quiet_assets', :group => :development
gem 'sidekiq'
gem 'sinatra', :require => nil # for the sidekiq web ui
gem 'google-analytics-rails'
gem 'redis'
gem 'redis-rails'
gem 'rollout'
gem 'rollbar' # exception service
gem 'oj', '~> 2.12.14'

gem 'mysql2', '~> 0.4.10'
gem 'sqlite3', require: false
gem 'devise', '~> 3'
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
gem 'merit'
gem "interactor-rails", "~> 2.0"

gem 'rambulance'
gem 'newrelic_rpm'
gem 'exception_notification'

gem 'github-markdown'
gem 'html_truncator'

gem 'will_paginate'
gem 'best_in_place', github: 'edk/best_in_place'
gem 'render_anywhere', :require => false

gem 'thinking-sphinx', '~> 3.1'

gem 'jquery-rails' # use version  '2.0.2' to specifically use jquery 1.7.2 (for select2)
gem 'select2-rails'
gem 'underscore-rails'
gem 'ledermann-rails-settings', :require => 'rails-settings'
gem 'jquery-ui-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'friendly_id'

gem 'coffee-rails', '~> 4.0.0'
gem 'simple_form'
gem 'foundation-rails'
# gem 'foundation_rails_helper' # https://github.com/sgruhier/foundation_rails_helper#usage
gem 'foundation-icons-sass-rails'
gem 'foundation-social-web-icons-rails', github: "jclusso/foundation-social-web-icons-rails"
gem 'sass-rails', '~> 4.0.0.rc2'
gem 'uglifier', '>= 1.3.0'
gem 'nokogiri'
gem 'faraday'
gem 'dotenv-rails'
gem 'dotenv-deployment'

group :development do
  gem "airbrussh", require: false
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'guard-livereload', require: false
  gem 'sanitize_email'
end

group :development, :test do
  gem 'pry'
  gem 'byebug'
  gem 'seed_dump'
  #gem 'protected_attributes' # only to get seed_dump to work
  gem 'rspec-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
