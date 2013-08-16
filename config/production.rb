require 'optparse'
args = ARGV.dup || []
opts = {
  port: 3000
}
OptionParser.new do |opt|
  opt.banner = 'Usage'
  opt.on('-p [port]', 'Start port') do |value|
    opts[:port] = value
  end
end.parse(args)

puts opts[:port]

configure do
  set :port, opts[:port]
  ## worker number can be detected by CPU count
  set :workers, 1
  set :logger, false

  # todo after_fork
end
