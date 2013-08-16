require "test_helper"

describe LiveChat::Client do
  it "should connect to the URI provided" do
    client = LiveChat::Client.new do |config|
      config.account = ENDPOINT
    end
    assert_equal ENDPOINT, client.account
  end

  it "should accept email and password auth options" do
    client = LiveChat::Client.new(:account => ENDPOINT, :email => EMAIL, :password => PASSWORD)
    assert_equal EMAIL, client.email
  end
end
