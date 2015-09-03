require 'helper'

describe SchoolLoop::Client do




  describe "error handling" do

    let(:unauth_client) do
      SchoolLoop.new do |config|
        config.subdomain  = 'subdomain'
        config.username   = 'username'
        config.password   = 'password'
        config.adapter    = :net_http
      end
    end

    # bad user, good password
    # 401 ERROR: Authorization failed: user or role not privileged.

    # bad user, bad password
    # 401 ERROR: Authorization failed: password incorrect.

    # api not enabled
    # 400 Error: OpenLoop is not enabled for subdomain.schoolloop.com. Contact School Loop.


    context "401 Unauthorized" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/)
          .to_return(status: 401, body: "ERROR: Authorization failed: password incorrect.")
      end
      it "raises an exception" do
        expect { unauth_client.get_roster }.to raise_error(SchoolLoop::Error::Unauthorized)
      end
    end

    context "400 Bad Request" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/)
          .to_return(status: 400, body: "some error message")
      end

      it "raises an exception" do
        expect { unauth_client.get_roster }.to raise_error(SchoolLoop::Error::BadRequest, "some error message")
      end
    end

    context "404" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/)
          .to_return(status: 404, body: "not found")
      end

      it "raises an exception" do
        expect { unauth_client.get_roster }.to raise_error(SchoolLoop::Error::ServiceError, "not found")
      end
    end

    context "503" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/)
          .to_return(status: 503, body: "backend failure")
      end

      it "raises an exception" do
        expect { unauth_client.get_roster }.to raise_error(SchoolLoop::Error::ServiceError, "backend failure")
      end
    end

    context "timeout" do
      before(:each) do
        stub_request(:any, /.*schoolloop\.com\/.*/).to_timeout
      end

      it "raises an exception" do
        expect { unauth_client.get_roster }.to raise_error(Faraday::TimeoutError)
      end
    end


  end
end
