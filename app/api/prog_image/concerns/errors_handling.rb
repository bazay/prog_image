require 'active_support/concern'

module ProgImage
  module ErrorsHandling
    extend ActiveSupport::Concern

    included do
      rescue_from ProgImage::Errors::ImageConversionError do |error|
        error_response status: 422, message: { base: error.exception.message }
      end
    end
  end
end
