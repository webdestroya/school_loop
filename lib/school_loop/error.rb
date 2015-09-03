module SchoolLoop
  module Error
    class SchoolLoopError < StandardError
      attr_reader :response_message, :response_headers

      def initialize(message)
        super message
        @response_message = message
      end
    end
  end
end

require "school_loop/error/service_error"
require "school_loop/error/bad_request"
require "school_loop/error/unauthorized"