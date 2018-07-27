module ProgImage
  class ImageConvertForm < ImageBaseForm
    attribute :key, String
    attribute :extension, String

    include FileNaming

    validate :ensure_extension_is_image, :ensure_extension_is_different, if: :extension

    def initialize(*args)
      super
      @tempfile = file_fetcher.fetch_file
      @extension ||= filename_extension(key)
    end

    def self.permitted_params
      %i[key extension]
    end

    def persist
      if valid?
        convert_image!
        upload_image!
      else
        false
      end
    end

    private

    def upload_image!
      upload_image.tap do |updated_key|
        update_key!(updated_key)
      end
    end

    def update_key!(updated_key)
      self.key = updated_key
    end

    def convert_image!
      self.filename = filename_with_extension(filename_from_key(key), extension)
      self.tempfile = image_handler.convert_extension(extension).tempfile
    end

    def ensure_extension_is_image
      errors.add(:extension) unless image_handler.image_extension?(extension)
    end

    def ensure_extension_is_different
      errors.add(:extension, :unchanged) unless image_handler.different_extension?(extension)
    end
  end
end
