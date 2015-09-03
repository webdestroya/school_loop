require 'school_loop/version'
require 'school_loop/configuration'
require 'school_loop/connection'
require 'school_loop/client'

module SchoolLoop
  extend Configuration

  class << self
    def new(options = {}, &block)
      SchoolLoop::Client.new(options, &block)
    end

    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end


end
