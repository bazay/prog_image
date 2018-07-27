module ProgImage
  module Errors
    class ImageConversionError < StandardError
      def initialize(message = 'Image could not be converted', extension: nil)
        super extended_message(message, extension)
      end

      private

      def extended_message(message, extension)
        extension.presence ? message + " to extension: #{extension}" : message
      end
    end
  end
end
