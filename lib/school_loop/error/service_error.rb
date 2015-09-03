# encoding: utf-8

module SchoolLoop #:nodoc
  # Raised when SchoolLoop returns any of the HTTP status codes
  module Error
    class ServiceError < SchoolLoopError
      attr_accessor :http_headers, :http_status, :http_method, :url

      def initialize(env)
        super(generate_message(env))
        @http_headers = env[:response_headers]
        @http_status = env[:status]
        @http_method = env[:method].to_s.upcase
        @url = env[:url].to_s
      end

      def generate_message(env)
        "#{env[:body]}"
      end
    end
  end # Error
end # SchoolLoop
