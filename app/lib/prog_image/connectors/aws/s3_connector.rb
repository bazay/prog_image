require 'aws-sdk-s3'

module ProgImage
  module Connectors
    module Aws
      class S3Connector < BaseConnector
        include ProgImage::FileNaming

        def fetch_file(key)
          fetched_file = ::File.open("tmp/#{temporary_filename(key)}", 'wb') do |file|
            client.get_object({ key: key, bucket: bucket_name }, target: file)
          end
          fetched_file.body
        end

        def fetch_file_url(key)
          bucket.object(key).public_url
        end

        def file_exists?(key)
          bucket.object(key).exists?
        end

        def upload_file(file_attributes, key)
          bucket.put_object file_upload_params(file_attributes, key)
          true
        rescue ::Aws::S3::Errors, ::Timeout::Error
          false
        end

        private

        def file_upload_params(file_attributes, key)
          {
            body: file_attributes[:tempfile],
            key: key,
            acl: 'public-read'
          }
        end

        def bucket
          @bucket ||= ::Aws::S3::Bucket.new region: region, credentials: credentials, name: bucket_name
        end

        def client
          @client ||= ::Aws::S3::Client.new region: region, credentials: credentials
        end

        def bucket_name
          Figaro.env.aws_bucket_name
        end
      end
    end
  end
end
