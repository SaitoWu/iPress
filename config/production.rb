require 'optparse'
args ||= []
opts = {
  port: 3000
}
OptionParser.new do |opt|
  opt.banner = 'Usage'
  opt.on('-p', 'Start port') do |value|
    opts[:port] = value
  end
end.parse(args)

configure do
  set :port, opts[:port]
  ## worker number can be detected by CPU count
  set :workers, 4
  set :logger, false

  # todo after_fork
end
