# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ipgeobase.gemspec
gemspec

gem "rake", "~> 13.0"

group :development do
  gem "rubocop", "~> 1.21"
end

group :test do
  gem "minitest", "~> 5.0"
  gem 'simplecov', require: false
end

group :development, :test do
  gem "webmock"
end