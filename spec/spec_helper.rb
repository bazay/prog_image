ENV['RACK_ENV'] ||= 'test'
require File.expand_path('../config/application', __dir__)

Dir[ProgImage.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Rack::Test::Methods
  config.include RequestSharedMethods, type: :request

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = false
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
