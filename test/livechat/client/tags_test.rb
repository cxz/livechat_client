require "test_helper"

describe Livechat::Client::Tags do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end
  end

  describe "GET" do
    it "should get up to the 100 most used tags" do
      tags = @zendesk.tags.fetch
      refute_empty tags
      assert tags.size < 100
    end
  end
end
