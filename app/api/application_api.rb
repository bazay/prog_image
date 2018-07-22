class ApplicationApi < Grape::API
  include ApiConfiguration

  desc 'Application and API version information'
  get :version do
    { version: ProgImage::VERSION, latest_api_version: configatron.api.latest_version.call }
  end
end
