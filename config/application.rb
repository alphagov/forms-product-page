require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

require "./app/lib/json_log_formatter"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FormsProductPage
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

    # All forms should use GOVUKDesignSystemFormBuilder by default
    config.action_view.default_form_builder = GOVUKDesignSystemFormBuilder::FormBuilder

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Use JSON log formatter for better support in Splunk. To use conventional
    # logging use the Logger::Formatter.new.
    config.log_formatter = JsonLogFormatter.new

    if ENV["RAILS_LOG_TO_STDOUT"].present?
      config.logger = ActiveSupport::Logger.new($stdout)
      config.logger.formatter = config.log_formatter
    end

    # Lograge is used to format the standard HTTP request logging
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new

    # Lograge suppresses the default Rails request logging. Set this to true to
    #  make lograge output it which includes some extra debugging
    # information.
    config.lograge.keep_original_rails_log = false
  end
end
