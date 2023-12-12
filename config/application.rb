require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Litretro
  Env = AppEnv::Environment.new do |env, src|
    env.pgdatabase = src.pgdatabase
    env.pguser = src.pguser
    env.pgpassword = src.pgpassword
    env.pghost = src.pghost
    env.pgport = src.pgport
    env.pgpool_size = src.pgpool_size
  end

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
