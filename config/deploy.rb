# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ember_demo'
set :repo_url, 'git@github.com:abhimanyubv/EmberCourseDemo.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/ember_demo'

# Default value for :scm is :git
set :scm, :git
set :deploy_via, :remote_cache

set :user, "deploy"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Start the application"
  task :start do
    on roles(:app) do |h|
      execute "service unicorn start", :pty => true
    end
  end

  desc "Stop the application"
  task :stop do
    on roles(:app) do |h|
      execute "service unicorn stop", :pty => true
    end
  end

  desc "Restart the application"
  task :restart do
    on roles(:app) do |h|
      execute "service unicorn restart", :pty => true
    end
  end

  after :publishing, :restart

  desc "Status of the application"
  task :status do
    on roles(:app) do |h|
      execute "service unicorn status"
    end
  end
end
