source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'omniauth-github', :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-openid', :git => 'git://github.com/intridea/omniauth-openid.git'

gem 'pry'
gem 'activerecord-session_store'
gem 'userstamp', :git => 'git@github.com:kimkong/userstamp.git'
gem 'paper_trail', :git => 'git@github.com:airblade/paper_trail.git', :branch=>'rails4'

# TODO
# https://github.com/joemccann/dillinger - a client-side markdown editor, perhaps use as a base
# https://github.com/krisleech/chalk_dust - chalk dust, an activity feed
# showterm.io,  https://github.com/chjj/tty.js https://github.com/liftoff/GateOne/ - a way to do terminal based screencasts.
# http://www.udjamaflip.com/javascript/98-html5-video-subtitles-utilising-mozilla-s-popcorn-js popcorn.js

group :development, :test do
  gem 'seed_dump', :git => 'git@github.com:rroblak/seed_dump.git'
  # gem 'protected_attributes' # only to get seed_dump to work
  gem 'rspec-rails', '~> 2.0'
end

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc2'
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'coffee-rails', '~> 4.0.0'
gem 'zurb-foundation', '~> 4.0.0'
gem 'jquery-rails' # use version  '2.0.2' to specifically use jquery 1.7.2 (for select2)
gem 'select2-rails'
gem 'underscore-rails'
# gem 'turbolinks' # https://github.com/rails/turbolinks
# gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]
