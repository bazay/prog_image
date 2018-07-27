module ProgImage
  class FileFetcher
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def fetch_file
      connector.fetch_file(key)
    end

    def fetch_file_url
      connector.fetch_file_url(key)
    end

    def file_exists?
      connector.file_exists?(key)
    end

    private

    def connector
      @connector ||= ::ProgImage::Connectors::Aws::S3Connector.new
    end
  end
end
