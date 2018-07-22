module ApiConfiguration
  extend ActiveSupport::Concern

  included do
    cascade true

    # include ErrorsHandling

    format :json
    default_format :json

    helpers ApiResponseHelper
  end
end
