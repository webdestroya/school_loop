# encoding: utf-8

require 'faraday'
require 'school_loop/error'

module SchoolLoop
  class Response::RaiseError < Faraday::Response::Middleware

    def on_complete(env)
      case env[:status].to_i
      when 400
        raise SchoolLoop::Error::BadRequest.new(env)
      when 401
        raise SchoolLoop::Error::Unauthorized.new(env)
      when 400...600
        raise SchoolLoop::Error::ServiceError.new(env)
      end
    end

  end # Response::RaiseError
end # SchoolLoop
