require 'helper'

describe SchoolLoop do

  describe ".new" do

    it "allows an instance to override the global configuration" do
      SchoolLoop.configure do |config|
        config.username = "test2"
        config.password = "setting2"
      end

      client = SchoolLoop.new

      expect(client.username).to eq "test2"
      expect(client.password).to eq "setting2"

      client2 = SchoolLoop.new(username: "test3", password: "setting3")
      expect(client2.username).to eq "test3"
      expect(client2.password).to eq "setting3"

      expect(client.username).to eq "test2"
      expect(client.password).to eq "setting2"

      client3 = SchoolLoop.new(username: "test4")
      expect(client3.username).to eq "test4"
    end

    it "does not modify the global configuration" do
      SchoolLoop.configure do |config|
        config.username = "testg"
        config.password = "passg"
      end

      client = SchoolLoop.new(username: "gtest", password: "gpass")

      expect(client.username).to eq "gtest"
      expect(client.password).to eq "gpass"

      expect(SchoolLoop.options[:username]).to eq "testg"
      expect(SchoolLoop.options[:password]).to eq "passg"
    end
  end


  describe ".method_missing" do
    let(:client_dbl) { double(SchoolLoop::Client) }

    before do
      allow(SchoolLoop).to receive(:new).and_return(client_dbl)
    end

    it "creates an instance and calls the method" do
      expect(client_dbl).to receive(:get_roster).with("1234").and_return(true)
      expect(SchoolLoop.get_roster("1234")).to be_truthy
    end
  end

  describe ".respond_to?" do
    it { expect(SchoolLoop).to respond_to(:get_roster) }
    it { expect(SchoolLoop).to respond_to(:publish_progress_report) }
  end

end
