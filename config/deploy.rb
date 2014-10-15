# require 'debugger'

set :application, 'tribalknow'
# set :repo_url, 'git@github.com:edk/tribalknow.git'
set :repo_url, 'https://github.com/edk/tribalknow.git'

set :branch, 'master'

set :deploy_to, '/home/deploy/tribalknow'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml config/initializers/secret_token.rb config/local_config.rb config/docs_config.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db/sphinx public/assets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "rebuild sphinx index"
  task :reindex do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "ts:index"
        end unless ENV["SKIP_TS"] == '1'
      end
    end
  end
  desc "start searchd"
  task :searchd_start do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "ts:restart"
        end
      end
    end
  end

  desc 'send out notification on deploy. set DEPLOY_NOTIFY=email@somewhere.com for this to work.'
  task :notify do
    current_revision = fetch :current_revision
    previous_revision = fetch :previous_revision
    log = ""
    on roles(:web) do
      within release_path do
        log = capture("cd #{repo_path} && git --no-pager log --pretty=\"format:%h - %s (%ar) <%an>\" #{previous_revision}..#{current_revision}")
      end
    end
    if ENV["DEPLOY_NOTIFY"]
      begin
        Mail.deliver do
          from    "deploy@tribalknownow.com"
          to      ENV["DEPLOY_NOTIFY"].split(',')
          subject "Deploy Notification #{current_revision} (#{fetch :stage})"
          body    "Current Revision #{current_revision}\nPrevious Revision: #{previous_revision}\n\n#{log}"
        end
      rescue
        puts "Unable to send deploy email. #{$!}"
      end
    else
      puts "WARNING:  DEPLOY_NOTIFY not set. export DEPLOY_NOTIFY='someone@somewhere' to enable deployment notifications"
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

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

  desc "Additional post deploy tasks"
  task :addl_deploy_work do
    on roles(:web) do
      execute :ln, '-nfs', "/home/deploy/docs", release_path.join("docs")
      execute :cp, "/home/deploy/favicon.ico", release_path.join("public/favicon.ico")
    end
  end

  after :finishing, 'deploy:addl_deploy_work'
  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:notify'
  after :finishing, 'deploy:reindex'
  after :finishing, 'deploy:searchd_start'
  after :finishing, 'deploy:restart'

  before 'deploy:migrate', :create_db_if_needed => [:set_rails_env] do
    on roles(:db) do
      need_to_create_and_seed = nil
      #as :postgres do
        #rv=capture :psql, '-tAc', "\\\"SELECT 1 FROM pg_database WHERE datname = 'tribalknow_production'\\\""
        #need_to_create_and_seed=true if rv.strip == ""
      #end
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
