# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Tribalknow::Application.load_tasks

Rails.application.load_tasks
Rake::Task['test'].clear

task :test do
  Rake::Task['spec'].invoke
end
