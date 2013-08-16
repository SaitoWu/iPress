require_relative 'config/application'
require "nyara/task"

task :generate_session_key do
  require "openssl"
  d = OpenSSL::PKey::DSA.generate(256)
  File.open("config/session.key","w") do |f|
    f.write(d.to_s)
  end
end