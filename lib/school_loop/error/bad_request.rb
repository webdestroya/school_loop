# encoding: utf-8

module SchoolLoop
  module Error
    # Raised when School Loop returns the HTTP status code 400
    class BadRequest < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end
end # BitBucket
