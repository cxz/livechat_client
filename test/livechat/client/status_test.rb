require "test_helper"

include WebMock::API


describe LiveChat::Client::Status do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    request_path = "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/status"
    stub_request(:any, /#{request_path}.*/)
  end

  after do
    WebMock.reset!
  end

  it "gets status" do
    @livechat.status(:group => 0)
  end

end

