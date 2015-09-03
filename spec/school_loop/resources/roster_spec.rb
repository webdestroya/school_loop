require 'helper'

describe SchoolLoop::Resources::Roster do

  let(:client) do
    SchoolLoop.new do |config|
      config.subdomain  = 'subdomain'
      config.username   = 'username'
      config.password   = 'password'
      config.adapter    = :net_http
    end
  end

  describe "#get_roster" do

    before do
      stub_request(:get, /.*schoolloop\.com\/api\/roster.*/)
        .to_return(status: 200, body: fixture("roster_response.xml").read,
          headers: {'Content-Type' => 'text/xml'}
        )
    end

    it "for entire school" do
      response = client.get_roster
      expect(a_request(:get, /.*subdomain\.schoolloop\.com\/api\/roster/)).to have_been_made.once

      expect(response.status).to eq 200
      expect(response.body).to be_a Nokogiri::XML::Document
      expect(response.body.xpath("//root/roster/teachers/teacher")[0].attr("name")).to eq "Reynolds, Mr. Malcom"
    end

    it "for a specific teacher" do
      response = client.get_roster("12345")
      expect(a_request(:get, /.*subdomain\.schoolloop\.com\/api\/roster/).with(query: {teacher_id: "12345"})).to have_been_made.once

      expect(response.status).to eq 200
      expect(response.body).to be_a Nokogiri::XML::Document
      expect(response.body.xpath("//root/roster/teachers/teacher")[0].attr("name")).to eq "Reynolds, Mr. Malcom"
    end
  end
end
