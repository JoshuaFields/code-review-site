if Rails.env.test? || Rails.env.development?
  REDIS = Redis.new(host: 'localhost', port: 6379)
else
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
end
