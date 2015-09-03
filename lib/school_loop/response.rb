
require 'faraday'

module SchoolLoop
  class Response < Faraday::Response::Middleware
    CONTENT_TYPE = 'Content-Type'.freeze

    class << self
      attr_accessor :parser
    end

    def self.define_parser(&block)
      @parser = block
    end

    def response_type(env)
      env[:response_headers][CONTENT_TYPE].to_s
    end
  end
end
