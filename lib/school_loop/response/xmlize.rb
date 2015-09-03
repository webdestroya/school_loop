# encoding: utf-8

require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/response_middleware'

module SchoolLoop
  class Response::Xmlize < ::FaradayMiddleware::ResponseMiddleware
    dependency 'nokogiri'

    define_parser do |body|
      ::Nokogiri::XML body
    end

    def parse(body)
      case body
      when ''
        nil
      when 'true'
        true
      when 'false'
        false
      else
        self.class.parser.call body
      end
    end
  end # Response::Xmlize
end # SchoolLoop
