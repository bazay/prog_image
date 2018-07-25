module ProgImage
  class FileFetcher
    attr_reader :key

    def initialize(key)
      @key = key
    end

    def fetch
      connector.fetch_file(key)
    end

    private

    def connector
      @connector ||= ::ProgImage::Connectors::Aws::S3Connector.new
    end
  end
end
