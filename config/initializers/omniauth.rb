
if !ENV['GITHUB_KEY'].present? || !ENV['GITHUB_SECRET'].present?
  puts "*" * 80
  puts "ENV['GITHUB_KEY'] is NOT SET."
  puts "ENV['GITHUB_SECRET'] is NOT SET"
  puts "use "
  puts "$ source github.env.vars"
  puts "*" * 80
else
  puts "GITHUB_SECRET and GITHUB_KEY set"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  require 'openid/store/filesystem' 
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp')
end

