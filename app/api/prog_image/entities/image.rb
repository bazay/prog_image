module ProgImage
  module Entities
    class Image < ImageKey
      expose :public_url, documentation: { type: 'String', desc: 'URL image is located' }
    end
  end
end
