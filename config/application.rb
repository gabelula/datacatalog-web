module DatacatalogWe
  class Application < Rails::Application
    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{RAILS_ROOT}/extras )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    config.frameworks -= [ :active_resource ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'UTC'

    config.action_controller.session = {
      :session_key => 'natdatcat',
      :secret      => 'f3f57b71ef9345ffccd0c4e841d8e74bb2e7d2ef692a506aa6c2a3c29d584a55dd18426ffc04610be49956a51af'
    }

    config.middleware.use "Rack::Honeypot"
  end
end

