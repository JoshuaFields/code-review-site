if ENV["REDISCLOUD_URL"]
  Redis.current = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  Redis.current = Redis.new(host: 'localhost', port: 6379)
end
