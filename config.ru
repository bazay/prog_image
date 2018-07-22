# This file is used by Rack-based servers to start the application.
start = Time.now
require_relative 'config/application'
run ProgImage::ApplicationApi
puts "Loaded in: #{Time.now - start}s"
