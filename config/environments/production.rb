# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.action_controller.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

mail_settings_file = Rails.root.join("config/mail_settings.yml")

# If there's no config file for the mail delivery settings, do nothing and
# assume the config comes magically from somewhere else. Like heroku's 
# sendgrid add-on.
if mail_settings_file.file?
  config.action_mailer.delivery_method = :smtp

  mail_settings = YAML.load_file(mail_settings_file)
  s = mail_settings["production"]
  config.action_mailer.smtp_settings = {
    :address      => s["address"],
    :port         => s["port"],
    :domain       => s["domain"],
    :authentication => :login,
    :user_name    => s["user_name"],
    :password     => s["password"]
  }
end

# Enable threaded mode
# config.threadsafe!
