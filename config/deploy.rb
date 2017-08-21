# config valid only for current version of Capistrano
lock "3.8.2"

set :repo_url,        'git@gitlab.com:maqui/spree-demo.git'
set :application,     'spree-demo'

set :rbenv_ruby, '2.4.1'
set :pty,             false

set :use_sudo,        false
set :deploy_via,      :copy
set :deploy_to,       "/home/spree/#{fetch(:application)}"
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :sidekiq_queue, %w{default mailers}

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end