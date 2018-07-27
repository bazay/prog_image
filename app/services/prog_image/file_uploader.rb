module ProgImage
  class FileUploader
    attr_reader :file_attributes, :key

    def initialize(file_attributes)
      @file_attributes = file_attributes
      @key = build_key_path
    end

    def upload
      connector.upload_file(file_attributes, key) ? key : false
    end

    private

    def build_key_path
      "#{SecureRandom.uuid}/#{@file_attributes[:filename]}"
    end

    def connector
      @connector ||= ::ProgImage::Connectors::Aws::S3Connector.new
    end
  end
end
