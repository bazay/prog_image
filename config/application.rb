require File.expand_path('../config/prog_image.rb', __dir__)
require File.expand_path('../config/environment.rb', __dir__)

# Require folders
%w[config/initializers/*.rb app/**/*.rb].each do |path|
  require_all ProgImage.root.join(path)
end

# Load I18n
I18n.load_path = Dir[ProgImage.root.join('config', 'locales', '*.yml')]

# Load Figaro
Figaro.application = Figaro::Application.new \
  environment: ProgImage.env,
  path: ProgImage.root.join('config', 'application.yml')
Figaro.load
