require 'active_model'

module ProgImage
  class BaseForm
    include ::ActiveModel::Model
    include Virtus.model
  end
end
