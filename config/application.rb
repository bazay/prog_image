require File.expand_path('../config/prog_image.rb', __dir__)
require File.expand_path('../config/environment.rb', __dir__)

# Require folders
%w[config/initializers/*.rb app/**/*.rb].each do |path|
  require_all ProgImage.root.join(path)
end
