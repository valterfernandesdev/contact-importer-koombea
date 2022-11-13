# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }

  Rails.logger = Sidekiq.logger
end

Sidekiq.configure_client do |config|
  config.redis = { size: Integer(5), db: 1 }
end
