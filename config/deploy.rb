# require 'debugger'

set :application, 'tribalknow'
# set :repo_url, 'git@github.com:edk/tribalknow.git'
set :repo_url, 'https://github.com/edk/tribalknow.git'

set :branch, 'master'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/deploy/tribalknow'
set :scm, :git

#set :format, :pretty
set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "uptime"
  task :uptime do |host|
    on roles(:all), in: :parallel do
      puts "deploy to = #{fetch(:deploy_to)}"
      uptime = capture(:uptime)
      puts "#{host.inspect} reports: #{uptime}"
    end
  end

  desc "load schema"
  task :schema_load => [:set_rails_env] do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:schema:load"
        end
      end
    end
  end

  desc "seed db"
  task :seed => [:set_rails_env] do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "setup db - cold. use this for a new app standup"
  task :db_setup_cold => [:schema_load, :seed] do
  end

  #TODO:
  # * will probably need some sort of task to configure the production solr configuration for a fresh install
  # * will also need tasks to manage and rebuild indexes

  after :finishing, 'deploy:cleanup'

  before 'deploy:migrate', :create_db_if_needed => [:set_rails_env] do
    on roles(:db) do
      need_to_create_and_seed = nil
      as :postgres do
        rv=capture :psql, '-tAc', "\\\"SELECT 1 FROM pg_database WHERE datname = 'tribalknow_production'\\\""
        need_to_create_and_seed=true if rv.strip == ""
      end
      if need_to_create_and_seed
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:create"
            execute :rake, "db:schema:load"
            execute :rake, "db:seed"
          end
        end
      end
    end
  end

  before 'deploy:starting', :pre_setup do
    on roles(:db) do |host|
      homedir   = '/home/deploy'
      basedir   = File.join(homedir, 'tribalknow') # host.deploy_to
      
      configdir = File.join(basedir, "shared", "config")
      execute :mkdir, '-p', configdir
      execute :cp, "#{homedir}/database.yml", "#{configdir}/"
      
      configdir = File.join(basedir, "shared", "config", "initializers")
      execute :mkdir, '-p', configdir
      execute :cp, "#{homedir}/secret_token.rb", "#{configdir}/"
      # TODO make the mkdir/cp conditional
    end
  end
end
