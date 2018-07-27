module ProgImage
  class ImageBaseForm < BaseForm
    attribute :filename, String
    attribute :type, String
    attribute :tempfile

    def persist
      raise NotImplementedError, 'must be defined in child class'
    end

    def public_url
      file_fetcher.fetch_file_url
    end

    private

    def upload_image
      file_uploader.upload
    end

    def image_handler
      @image_handler ||= ImageHandler.new(tempfile)
    end

    def file_uploader
      @file_uploader ||= FileUploader.new(attributes)
    end

    def file_fetcher
      FileFetcher.new(key)
    end
  end
end
