# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

#Tribalknow::Application.load_tasks # will remove later, this causes a double run of specs
# as long as the rake tasks run properly in heroku without this, this can be removed

Rails.application.load_tasks

# use spec task instead of default rails tests
Rake::Task['test'].clear

task :test do
  Rake::Task['spec'].invoke
end
