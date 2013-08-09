desc "display all routes"
task :routes do
  require_relative 'config/application'
  Nyara.setup
  Nyara::Route.print_routes
end

namespace :assets do
  desc "Regenerate asset files"
  task :generate do
    print "Assets css files in compressing..."
    `bundle exec sass --cache-location tmp/cache/sass --update app/assets/css:public/css -t compressed -f`
    puts " [Done]"
    print "Assets js files in compressing..."
    `bundle exec coffee -c -b -o public/js app/assets/js `
    puts " [Done]"
  end
end