source 'https://rubygems.org'

gem 'rails', '~> 4.0'
gem 'activerecord-session_store'
gem 'haml-rails'
gem 'jbuilder', '~> 1.2'
gem 'quiet_assets', :group => :development
#gem 'puma'

gem 'pg'
gem 'devise'
gem 'omniauth-github'
gem "pundit"

#gem 'userstamp', :path => '../userstamp'
gem 'ckeditor_rails'
gem 'paper_trail', :git => 'git@github.com:airblade/paper_trail.git', :branch=>'rails4'
gem 'public_activity'
gem 'redcarpet'
gem 'simple_form', :git => 'git@github.com:plataformatec/simple_form.git', :tag=>'v3.0.0.rc'
gem 'userstamp', :git => 'git@github.com:kimkong/userstamp.git'
gem 'will_paginate'

gem 'thinking-sphinx', '~> 3.1'
gem 'mysql2' # uhhhh, i'm using postgres, but ts has a dependency on mysql2.  wtf

gem 'jquery-rails' # use version  '2.0.2' to specifically use jquery 1.7.2 (for select2)
gem 'select2-rails'
gem 'underscore-rails'
gem 'exception_notification'


# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'coffee-rails', '~> 4.0.0'
gem 'foundation-rails'
# gem 'foundation_rails_helper' # https://github.com/sgruhier/foundation_rails_helper#usage
gem 'foundation-icons-sass-rails'
gem 'foundation-social-web-icons-rails', git: "git://github.com/jclusso/foundation-social-web-icons-rails.git"
gem 'sass-rails', '~> 4.0.0.rc2'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
end

group :development, :test do
  gem 'pry'
  gem 'byebug'
  gem 'seed_dump'
  #gem 'protected_attributes' # only to get seed_dump to work
  gem 'rspec-rails', '~> 2.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
