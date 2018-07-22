# This file is used by Rack-based servers to start the application.
start = Time.now
require_relative 'config/environment'

run Rails.application
puts "Loaded in: #{Time.now - start}s"
