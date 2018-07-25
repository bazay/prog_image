module ProgImage
  module Helpers
    module S3DirectUpload
      def presign_upload_file(file)
        connector.direct_upload_file(file)
      end

      private

      def connector
        @connector ||= ::ProgImage::Connectors::Aws::S3Connector.new
      end
    end
  end
end
