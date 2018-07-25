module ProgImage
  class FileUploader
    attr_reader :file, :key

    def initialize(file)
      @file = file
      @key = build_key_path(file)
    end

    def upload
      connector.upload_file(file, key) ? key : false
    end

    private

    def build_key_path(file)
      "#{SecureRandom.uuid}/#{file[:filename]}"
    end

    def connector
      @connector ||= ::ProgImage::Connectors::Aws::S3Connector.new
    end
  end
end
