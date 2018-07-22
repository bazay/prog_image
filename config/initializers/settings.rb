# Universal settings file
configatron.api.versions = %w[v1.0]
configatron.api.latest_version = -> { configatron.api.versions.last }
