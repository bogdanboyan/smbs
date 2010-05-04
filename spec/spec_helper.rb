# We are in test environment
ENV["RAILS_ENV"] = "test"

# Load rspec for rails
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec/rails'
