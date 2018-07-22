module ProgImage
  class ApplicationApi < Grape::API
    cascade true
    format :json
    default_format :json
    prefix :api

    helpers ProgImage::ApiResponseHelper

    desc 'Application and API version information'
    get :version do
      { version: ProgImage.version, latest_api_version: configatron.api.latest_version.call }
    end
  end
end
