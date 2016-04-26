lock '3.4.0'

set :application, 'dat_orchestra'
set :repo_url, 'git@bitbucket.org:Aleks_Senkou/dat_orchestra.git'

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

  task :puts_message do
    on roles(:app), in: :sequence, wait: 0 do
      puts "HERE" * 50
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  before 'deploy:assets:precompile', 'deploy:migrate'
  before 'deploy:migrate', :puts_message

  before :finishing, :restart
end
