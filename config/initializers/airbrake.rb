Airbrake.configure do |config|
  config.api_key = 'e520648bd29e905966526d342515a338'
  config.host    = 'errbit.evergreen.edu'
  config.port    = 80
  config.secure  = config.port == 443
end
