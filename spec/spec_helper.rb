# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  
  # Turn on GC
  config.before(:all) do
    DeferredGarbageCollection.start
  end
  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
  
  # Turn Database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
end


# Global project assets dictionary

JS_DIRECTORIES = Jammit.configuration[:javascripts].each_pair do |key, value|
  Jammit.configuration[:javascripts][key] = value.map { |pattern| Dir[pattern] }.flatten.delete_if{ |file| file =~ /.jst/ }
end

CSS_DIRECTORIES = Jammit.configuration[:stylesheets].each_pair do |key, value|
  Jammit.configuration[:stylesheets][key] = value.map { |pattern| Dir[pattern] }.flatten
end
