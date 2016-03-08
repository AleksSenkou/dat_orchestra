lock '3.4.0'

set :application, 'dat_orchestra'
set :repo_url, 'git@bitbucket.org:Aleks_Senkou/dat_orchestra.git'

set :deploy_to, '/home/deploy/dat_orchestra'
set :rbenv_path, '/home/deploy/.rbenv'
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

set :keep_releases, 15


# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :passenger_restart_with_touch, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # after :finishing, 'deploy:cleanup'
end
