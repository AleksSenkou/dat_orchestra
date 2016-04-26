set :stage, :production
set :user, 'deploy'

server '46.101.113.116', user: fetch(:user), roles: %w{web app db}
