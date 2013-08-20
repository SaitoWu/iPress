require 'bundler'
Bundler.require :default, ENV['NYARA_ENV'] || 'development'

configure do
  set :env, ENV['NYARA_ENV'] || 'development'

  set :port, ENV['NYARA_PORT']

  set :views, 'app/views'

  set :session, :name, '_ipress'

  ## If you've configured https with nginx:
  # set :session, :secure, true

  ## Default session expires when browser closes.
  ## If you need time-based expiration, 30 minutes for example:
  set :session, :expires, 30 * 24 * 30 * 60
  
  set 'session', 'key', File.read(project_path 'config/session.key')

  # Routing
  map '/', 'users'
  map '/account', 'account'
  map '/posts', 'posts'

  # Environment specific configure at last
  require_relative env
  
  # invoked after forking a worker
  set :after_fork, ->{
    Mongoid.load! Nyara.project_path('config/mongoid.yml'), Nyara.env
  }
end

# load app
Dir.glob %w|
  lib/**/*.rb
  app/controllers/application_controller.rb
  app/models/mongoid/base_model.rb
  app/{helpers,models,controllers}/**/*.rb
| do |file|
  require_relative "../#{file}"
end

# compile routes and finish misc setup stuffs
Nyara.setup

# connect db in interactive shell
Nyara.config[:after_fork].call if ENV['NYARA_SHELL']
