require 'mimemagic'
require 'mini_magick'

module ProgImage
  class ImageHandler
    attr_reader :original_image_file

    def initialize(image_file)
      @original_image_file = image_file
    end

    def image_file
      handler.open(::File.open(original_image_file))
    rescue MiniMagick::Invalid
      nil
    end

    def image?
      !!image_file.presence
    end

    def image_extension?(extension)
      ::MimeMagic.by_extension(extension).image?
    end

    def different_extension?(extension)
      image_file.type != extension.upcase
    end

    def convert_extension(extension)
      if image_extension?(extension) && different_extension?(extension)
        image_file.format(extension).tap do
          clear_original_image_file!
        end
      elsif !different_extension?(extension)
        original_image_file
      end
    rescue MiniMagick::Error
      raise ProgImage::Errors::ImageConversionError, extension: extension
    end

    private

    def handler
      ::MiniMagick::Image
    end

    def clear_original_image_file!
      ::File.delete original_image_file
    end
  end
end
