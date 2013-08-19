require "test_helper"

include WebMock::API


describe LiveChat::Client::Chats do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    request_path = "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/chats"
    stub_request(:any, /#{request_path}.*/)
  end

  after do
    WebMock.reset!
  end


  it "gets list of chats" do
    @livechat.chats.fetch
  end

  it "gets single chat" do
    @livechat.chats('MH022RD0K5').fetch
  end

  it "sends chat transcript to e-mail" do
    @livechat.chats('MH022RD0K5').send_transcript(:to => 'john.doe@mycompany.com')
  end


end

