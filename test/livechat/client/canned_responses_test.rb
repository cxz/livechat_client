require "test_helper"

include WebMock::API


describe LiveChat::Client::CannedResponses do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    request_path = "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/canned_responses"
    stub_request(:any, /#{request_path}.*/)
  end

  after do
    WebMock.reset!
  end

  it "lists all canned responses" do
    @livechat.canned_responses
  end

  it "gets a single canned response" do
    @livechat.canned_responses(0)
  end

  it "creates a new canned response" do
    canned_response = @livechat.canned_responses.create do |r|
      r[:text] = 'Have a great day, goodbye.'
      r[:tags] = ['cu', 'bye']
    end
  end

  it "updates a canned response" do
   @livechat.canned_responses(0).update do |r|
     r[:tags] = ['bye']
   end
  end

  it "removes a canned response" do
    @livechat.canned_responses(0).delete
  end

end

