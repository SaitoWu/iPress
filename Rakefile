require "rake"

Dir.chdir __dir__

desc "print all routes"
task :routes do
  require_relative "config/application"
  Nyara::Route.print_routes
end

namespace :assets do
  desc "compile assets into public (requires linner)"
  task :build do
    sh 'bundle exec linner build'
  end

  desc "clean assets in public (requires linner)"
  task :clean do
    sh 'bundle exec linner clean'
  end
end
