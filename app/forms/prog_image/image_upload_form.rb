module ProgImage
  class ImageUploadForm < ::ProgImage::BaseForm
    attr_reader :key

    attribute :filename, String
    attribute :type, String
    attribute :head, String
    attribute :tempfile

    validates :filename, format: { with: configatron.file.valid_filename_regex }
    validate :ensure_file_is_an_image

    def self.permitted_params
      %i[filename type name tempfile head]
    end

    def persist
      valid? ? @key = upload_image : false
    end

    private

    def upload_image
      file_uploader.upload
    end

    def ensure_file_is_an_image
      errors.add(:base) unless image_handler.image?
    end

    def image_handler
      @image_handler ||= ImageHandler.new(tempfile)
    end

    def file_uploader
      @file_uploader ||= FileUploader.new(attributes)
    end
  end
end
