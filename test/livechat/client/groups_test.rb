require "test_helper"

include WebMock::API


describe LiveChat::Client::Chats do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
      config.debug = true
    end

    request_path = "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/groups"
    stub_request(:any, /#{request_path}.*/)
  end

  after do
    WebMock.reset!
  end


  it "lists all groups" do
    @livechat.groups.fetch
  end

  it "gets a single group details" do
    @livechat.groups(2).fetch
  end

  it "creates a new group" do
    @livechat.groups.create do |group|
      group[:name] = 'Human Resources'
      group[:agents] = ['jenny.doe@mycompany.com', 'john.doe@mycompany.com']
    end
  end

  it "updates a group" do
    @livechat.groups(3).update do |group|
      group[:name] = 'Quality Assurance'
      group[:agents] = ['jane.doe@mycompany.com']
    end
  end

  it "removes a group" do
    @livechat.groups(4).delete
  end

end

