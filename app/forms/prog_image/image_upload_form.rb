module ProgImage
  class ImageUploadForm < ImageBaseForm
    attr_reader :key

    validates :filename, format: { with: configatron.file.valid_filename_regex }
    validate :ensure_file_is_an_image

    def self.permitted_params
      %i[filename type tempfile]
    end

    def persist
      valid? ? @key = upload_image : false
    end

    private

    def ensure_file_is_an_image
      errors.add(:base) unless image_handler.image?
    end
  end
end
