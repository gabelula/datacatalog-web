require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'ostruct'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module DatacatalogWeb
  class Application < Rails::Application
    # Add additional load paths for your own custom dirs
    config.autoload_paths += %W( #{Rails.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'UTC'

    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file
    config.filter_parameters += [:password]

    config.middleware.use "Rack::Honeypot"
    
  end
end
