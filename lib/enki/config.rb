require 'delegate'

module Enki
  class Config < SimpleDelegator
    def initialize(file_name)
      super(symbolize_keys(YAML::load(IO.read(file_name))))
    end

    def [](*path)
      path.inject(__getobj__()) {|config, item|
        config[item]
      }
    end

    def author_auths
      self[:author, :auths]
    end

    def self.default
      Enki::Config.new(default_location)
    end

    def self.default_location
      "#{Rails.root}/config/enlil.yml"
    end

    private

    def symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = case value
          when Hash then symbolize_keys(value)
          when Array then value.map{|item| symbolize_keys(item) }
          else value
        end
        options
      end
    end
  end
end
