require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
# require 'active_model/railtie'
# require 'active_job/railtie'
# require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
# require 'action_cable/engine'
# require 'sprockets/railtie'
# require 'rails/test_unit/railtie'
# require 'rack-timer'

Bundler.require(*Rails.groups)

module ProgImage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.paths.add File.join('app/api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app/api/*')]

    # Custom middleware
    # config.middleware.use RackTimer::Middleware
  end
end

require 'application_versioning'
