require 'helper'

describe SchoolLoop::Configuration do

  describe ".configure" do

    it "sets global configuration settings" do
      SchoolLoop.configure do |config|
        config.username = "test2"
        config.password = "setting2"
      end

      expect(SchoolLoop.options[:username]).to eq "test2"
      expect(SchoolLoop.options[:password]).to eq "setting2"

      client = SchoolLoop.new

      expect(client.username).to eq "test2"
      expect(client.password).to eq "setting2"
    end

    it "allows the user to specify extra config options" do
      SchoolLoop.configure do |config|
        config.connection_options = {ssl: {verify: false}, request: {timeout: 1234}}
      end

      client = SchoolLoop.new
      expect(client.connection.options.timeout).to eq 1234
    end

    describe ":secure" do
      it { expect(SchoolLoop.new(secure: false, subdomain: "test").connection.url_prefix.scheme).to eq "http" }

      it { expect(SchoolLoop.new(secure: true, subdomain: "test").connection.url_prefix.scheme).to eq "https" }
      it { expect(SchoolLoop.new(subdomain: "test").connection.url_prefix.scheme).to eq "https" }
    end

  end


end
