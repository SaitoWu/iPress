configure do
  set :port, 3000
  ## worker number can be detected by CPU count
  set :workers, 4
  set :logger, false

  # todo after_fork
end
