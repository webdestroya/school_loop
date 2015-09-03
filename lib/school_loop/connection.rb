require 'faraday'
require 'faraday_middleware'
require 'school_loop/response'
require 'school_loop/response/raise_error'
require 'school_loop/response/xmlize'

module SchoolLoop
  module Connection
    extend self


    def connection
      @connection ||= Faraday.new({url: "#{secure ? 'https' : 'http'}://#{subdomain}.schoolloop.com"}.merge(connection_options)) do |faraday|
        faraday.request :basic_auth, username, password
        faraday.headers[:user_agent] = user_agent

        if debug
          faraday.response :logger
        end

        faraday.use SchoolLoop::Response::Xmlize,  :content_type => /\bxml$/
        faraday.use SchoolLoop::Response::RaiseError
        faraday.adapter adapter
      end
    end

  end
end
