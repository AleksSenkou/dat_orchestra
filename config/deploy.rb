lock '3.4.0'

require 'pry'

set :application, 'dat_orchestra'
set :repo_url, 'git@bitbucket.org:Aleks_Senkou/dat_orchestra.git'

set :ssh_options, { forward_agent: true}

set :deploy_to, '/home/deploy/dat_orchestra'
set :rbenv_path, '/home/deploy/.rbenv'
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

set :keep_releases, 25

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/documents}

set :passenger_restart_with_touch, true

namespace :deploy do

  Rake::Task["deploy:assets:precompile"].clear

  before :finishing, :restart

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  namespace :assets do
    desc "Precompile assets locally and then rsync to web servers"
    task :precompile do
      on roles(:web) do
        rsync_host = host.to_s

        run_locally do
          execute "rake assets:precompile"
          execute "rsync -av --delete ./public/assets/ #{fetch(:user)}@#{rsync_host}:#{shared_path}/public/assets/"
          execute "rm -rf public/assets"
        end
      end
    end
  end

end
