Rack::MiniProfiler.config.storage_options = {url: ENV["REDIS_URL"]}
Rack::MiniProfiler.config.storage = Rack::MiniProfiler::RedisStore
