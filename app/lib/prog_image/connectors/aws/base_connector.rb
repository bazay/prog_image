require 'aws-sdk-core'

module ProgImage
  module Connectors
    module Aws
      class BaseConnector
        private

        def credentials
          @credentials ||= ::Aws::Credentials.new access_key_id, access_key
        end

        def access_key_id
          Figaro.env.aws_access_key_id!
        end

        def access_key
          Figaro.env.aws_access_key!
        end

        def region
          Figaro.env.aws_region!
        end
      end
    end
  end
end
