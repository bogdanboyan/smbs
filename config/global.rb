require 'yaml'

require 'active_support/basic_object'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/hash/deep_merge'

#
# Global is configuration
#
# == Description ==
#
# It looks like Hash object but with accessors methods.
# It load and merge recursive configurations from files:
#
# config/global.yml
# config/namespace1.yml
# config/namespace1/namespace2.yml
# config/namespace1/namespace/namespace3.yml
# ...
#
# == Loading ==
# 
# Load configuration for certain environment
# > Global.configuration("qa")
#
# Reload configuration for current environment
# > Global.configuration(true)
#
# == Usage ==
# 
# > Global.smtp_settings.port
#
module Global
  class Configuration < ::ActiveSupport::BasicObject
    def initialize(hash)
      @hash = hash
    end

    def to_hash
      @hash
    end

    def key?(key)
      @hash.key?(key)
    end

    def [](key)
      @hash[key]
    end
    
    def []=(key, value)
      @hash[key] = value
    end
    
    def inspect
      @hash.inspect
    end

    protected

    def method_missing(method, *args, &block)
      @hash.key?(method) ? @hash[method] : super
    end
  end

  class << self

    def reload!(env = Rails.env)
      @configuration = nil
      configuration(env)
    end

    def configuration(env = Rails.env)
      @configuration ||= load_configuration(File.join(File.dirname(__FILE__), 'global.yml'), env)
    end

    protected
    
    def load_configuration(file, env)
      configurations = YAML.load_file(file)
      configuration = configurations[:default] || {}
      configuration.deep_merge!(configurations[env] || {})

      if dir = file.chomp('.yml') and File.directory?(dir)
        Dir[File.join(dir, '*.yml')].each do |file|
          configuration.deep_merge!(File.basename(file, '.yml') => load_configuration(file, env))
        end
      end

      Configuration.new(configuration.with_indifferent_access)
    end
    
    def method_missing(method, *args, &block)
      configuration.key?(method) ? configuration[method] : super
    end
  end
end