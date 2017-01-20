require "spec_helper"

include WebMock::API

describe LiveChat::REST::Status do
  before do
    @livechat = create_client

    stub_request(:any, /.*status/)
  end

  after do
    WebMock.reset!
  end

  it "gets status" do
    @livechat.status(:group => 0)
  end
end

