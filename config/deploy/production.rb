server '18.231.23.5', user: 'spree', roles: [:web, :app, :db]
set :puma_threads,    [1, 4]
set :puma_workers,    0
set :rbenv_ruby,      '2.4.1'
set :stage,           :production
set :branch,          :master