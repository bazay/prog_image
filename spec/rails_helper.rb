ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'action_controller/railtie'
require 'rspec/rails'
require 'rspec/its'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include RequestSharedMethods, type: :request

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
  # config.include Rack::Test::Methods
end
