require 'helper'

describe SchoolLoop::Resources::ProgressReports do

  let(:client) do
    SchoolLoop.new do |config|
      config.subdomain  = 'subdomain'
      config.username   = 'username'
      config.password   = 'password'
      config.adapter    = :net_http
    end
  end

  describe "#publish_progress_report" do

    it "publishes a progress report" do
      stub_request(:post, "https://username:password@subdomain.schoolloop.com/api/progressReports")
        .to_return(status: 200, body: "SUCCESS\n")

      response = client.publish_progress_report("<xml/>")
      expect(a_request(:post, /.*subdomain\.schoolloop\.com\/api\/progressReports/)).to have_been_made.once

      expect(response.status).to eq 200
      expect(response.body).to eq "SUCCESS\n"
    end

    context "errors" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/)
          .to_return(status: 400, body: "Error: failed to parse XML reports. No reports found. Check XML syntax.")
      end


      it { expect { client.publish_progress_report("<xml/>") }.to raise_error(SchoolLoop::Error::BadRequest) }
      it { expect { client.publish_progress_report("<xml/>") }.to raise_error("Error: failed to parse XML reports. No reports found. Check XML syntax.") }
    end

  end
end
