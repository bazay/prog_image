# Universal settings file
configatron.api.versions = %w[v1.0]
configatron.api.latest_version = -> { configatron.api.versions.last }
configatron.file.valid_filename_regex = /\A[\w,\s-]+\.[A-Za-z]{3}\z/
