module SchoolLoop
  module Resources
    module Roster

      # Get the roster for all teachers, or limit to a specific teacher
      def get_roster(teacher_id = nil)
        connection.get do |req|
          req.url "/api/roster"

          if teacher_id
            req.params['teacher_id'] = teacher_id
          end
        end
      end

    end
  end
end