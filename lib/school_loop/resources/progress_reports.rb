module SchoolLoop
  module Resources
    module ProgressReports

      def publish_progress_report(xml_body)
        connection.post do |req|
          req.url "/api/progressReports"
          req.headers['Content-Type'] = "application/xml"
          req.body = xml_body
        end
      end

    end
  end
end