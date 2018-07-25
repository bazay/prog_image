module ProgImage
  class ImageHandler
    attr_reader :original_file

    def initialize(image_file)
      @original_file = image_file
    end

    def image_file
      @image_file ||= handler.open(original_file.path)
    rescue MiniMagick::Invalid
      nil
    end

    def image?
      !!image_file.presence
    end

    private

    def handler
      ::MiniMagick::Image
    end

    def supported_image_formats
      configatron.file.supported_image_formats
    end
  end
end
