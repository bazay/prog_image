source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'configatron'
gem 'grape'
gem 'puma', '~> 3.11'
gem 'rack-timer' # Check for slow, unnecessary middleware
gem 'rails', '~> 5.2.0'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  gem 'rspec-its', require: false
  gem 'rspec-rails', require: false
end
