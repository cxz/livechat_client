require "test_helper"

include WebMock::API


describe LiveChat::Client::Chats do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    request_path = "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/goals"
    stub_request(:any, /#{request_path}.*/)
  end

  after do
    WebMock.reset!
  end


  it "lists all goals" do
    @livechat.goals.fetch
  end

  it "gets a single goal details" do
    @livechat.goals(1181).fetch
  end

  it "marks goal as successful" do
    @livechat.goals(1181).mark_as_successful(:visitor_id => 1)
  end

  it "adds a new goal" do
    @livechat.goals.create do |goal|
      goal[:name] = 'new goal'
      goal[:type] = 'url'
    end
  end

  it "updates a goal" do
    @livechat.goals(2231).update do |goal|
      goal[:name] = 'updated goal'
    end
  end

  it "removes a goal" do
    @livechat.goals(2231).delete
  end

end

