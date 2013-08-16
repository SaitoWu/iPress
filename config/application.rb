require 'bundler'
Bundler.require :default, ENV['NYARA_ENV'] || 'development'

configure do
  set :env, ENV['NYARA_ENV'] || 'development'

  set :views, 'app/views'

  set :assets, 'app/assets'

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
  

  # Application loading order
  set :app_files, %w|
    app/controllers/application_controller.rb
    app/models/mongoid/base_model.rb
    app/{helpers,models,controllers}/**/*.rb
  |

  # Environment specific configure at last
  require_relative env
end

# Configure Mongoid
Mongoid.load!(Nyara.config.project_path('config/mongoid.yml'), Nyara.config.env)

Nyara.load_app

