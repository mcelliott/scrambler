def redis_url
  ENV['REDIS_URL'] || 'redis://localhost:6379'
end

unless Rails.env == 'test'

  Sidekiq.configure_server do |config|
    config.redis = { url: redis_url }
    # config.poll_interval = 15
    config.options[:timeout] = 8
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: redis_url }
    config.options[:timeout] = 8
  end
end
