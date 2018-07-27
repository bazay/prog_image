module ProgImage
  module FileNaming
    def plain_filename(key)
      filename_from_key(key).split('.').first
    end

    def filename_with_extension(original_filename, extension)
      "#{plain_filename(original_filename)}.#{extension}"
    end

    def filename_from_key(key)
      key.split('/').last
    end

    def filename_extension(key)
      filename_from_key(key).split('.').last
    end

    def temporary_filename(key)
      "#{SecureRandom.uuid}-#{filename_from_key(key)}"
    end
  end
end
