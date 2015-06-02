source 'https://rubygems.org'
ruby '2.2.2'

require 'erb'
require 'json'

# Base
gem 'grape'
gem 'grape-jbuilder'
gem 'grape_logging'
gem 'pg'
gem 'activesupport', require: 'active_support'
gem 'rom-sql'

group :test, :development do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop', require: false
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'fabrication'
  gem 'json-schema'
end



