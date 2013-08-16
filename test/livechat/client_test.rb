require "test_helper"

describe Livechat::Client do
  it "should connect to the URI provided" do
    client = Livechat::Client.new do |config|
      config.account = ENDPOINT
    end
    assert_equal ENDPOINT, client.account
  end

  it "should accept email and password auth options" do
    client = Livechat::Client.new(:account => ENDPOINT, :email => EMAIL, :password => PASSWORD)
    assert_equal EMAIL, client.email
  end
end
