module ProgImage
  module Entities
    class Image < Grape::Entity
      expose :key, documentation: { type: 'String', desc: 'Unique identifier for your image' }
      expose :public_url, documentation: { type: 'String', desc: 'URL image is located' }
    end
  end
end
