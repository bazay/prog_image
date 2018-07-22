source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'configatron'
gem 'grape'
gem 'puma', '~> 3.11'
gem 'rack'
gem 'require_all'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-its'
end
