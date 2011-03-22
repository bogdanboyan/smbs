require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

# Load global congiguration
require File.expand_path('../global', __FILE__)

module Smbs
  class Application < Rails::Application
    
    CURRENT_TAG =  'v0.7.10' #`git tag | tail -1`.chomp
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    config.plugins = [ :barby ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.observers = :dashboard_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kyiv'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    
    # Use SQL instead of Active Record's schema dumper when creating the test database.
    config.active_record.schema_format = :sql

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [ :password ]

    config.action_mailer.default_url_options = { :host => Global.host }
    
    config.middleware.use ExceptionNotifier, {
      :email_prefix          => "[Yamco #{Rails.env}] ",
      :sender_address        => %{"Application Error" <support@yam.co.ua>},
      :exception_recipients  => %w{app.support@yam.co.ua},
      :ignore_exceptions     => []
    }
    
    # Load lib
    config.after_initialize do
      require 'clicks_agregator'
      require 'barby_barcode'
    end
    
  end
end
