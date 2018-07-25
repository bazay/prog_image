module ProgImage
  module Api
    class V10 < Grape::API
      version 'v1.0'.freeze

      mount Api::V10::Images
    end
  end
end
