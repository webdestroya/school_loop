# encoding: utf-8

module SchoolLoop #:nodoc
  # Raised when SchoolLoop returns the HTTP status code 401
  module Error
    class Unauthorized < SchoolLoopError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end # SchoolLoop
