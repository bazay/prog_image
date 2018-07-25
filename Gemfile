source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'activemodel'
gem 'aws-sdk-s3', require: false
gem 'configatron'
gem 'figaro'
gem 'grape'
gem 'grape-entity'
gem 'mini_magick', '~> 4.8'
gem 'puma', '~> 3.11'
gem 'rack'
gem 'require_all'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec-mocks'
end
