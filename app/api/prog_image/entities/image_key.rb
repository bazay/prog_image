module ProgImage
  module Entities
    class ImageKey < Grape::Entity
      expose :key, documentation: { type: 'String', desc: 'Unique identifier for your image' }
    end
  end
end
