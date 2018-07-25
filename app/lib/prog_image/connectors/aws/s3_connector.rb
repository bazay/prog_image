require 'aws-sdk-s3'

module ProgImage
  module Connectors
    module Aws
      class S3Connector < BaseConnector
        def upload_file(file, key)
          bucket.put_object file_upload_params(file, key)
          true
        rescue ::Aws::S3::Errors, ::Timeout::Error
          false
        end

        def fetch_file(key)
          bucket.object(key)
        end

        private

        def file_upload_params(file, key)
          {
            body: file[:tempfile],
            key: key,
            acl: 'public-read'
          }
        end

        def bucket
          @bucket ||= ::Aws::S3::Bucket.new region: region, credentials: credentials, name: bucket_name
        end

        def bucket_name
          Figaro.env.aws_bucket_name
        end
      end
    end
  end
end
