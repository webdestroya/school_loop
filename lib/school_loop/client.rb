require 'school_loop/configuration'
require 'school_loop/connection'
require 'school_loop/resources'

module SchoolLoop
  class Client
    include Connection

    include Resources::ProgressReports
    include Resources::Roster

    attr_reader *Configuration::VALID_OPTIONS_KEYS

    # Callback to update global configuration options
    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
        end
      end
    end

    # Creates new API
    def initialize(options={}, &block)
      super()
      setup options

      self.instance_eval(&block) if block_given?
    end

    def setup(options={})
      options = SchoolLoop.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  end
end
