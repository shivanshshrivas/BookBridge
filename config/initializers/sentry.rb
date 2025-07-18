Sentry.init do |config|
  config.dsn = ""
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = 0
  config.profiles_sample_rate = 0
  config.enabled_environments = %w[production staging]
end
