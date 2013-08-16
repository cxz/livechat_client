require "test_helper"

include WebMock::API


describe LiveChat::Client::Reports do
  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    stub_request(:get, /https:\/\/#{LOGIN}:#{API_KEY}@#{ENDPOINT}\/reports.*/).to_return(:body => {})
  end

  after do
    WebMock.reset!
  end

  it "gets dashboard data" do
    @livechat.reports.dashboard
  end

  it "gets dashboard data for agent" do
    @livechat.reports.dashboard(:agent => 'john.doe@mycompany.com')
  end

  it "gets dashboard data for group" do
    @livechat.reports.dashboard(:group => 1)
  end

  it "gets chats report" do
    @livechat.reports.chats(:date_from => '2013-01-01')
  end

  it "gets ratings report" do
    @livechat.reports.ratings(:group => 1)
  end

  it "gets ratings ranking" do
    @livechat.reports.ratings_ranking(:group => 1)
  end

  it "gets queued visitors report" do
    @livechat.reports.queued_visitors(:date_from => '2013-01-01')
  end

  it "gets queue waiting times report" do
    @livechat.reports.queued_visitors_waiting_times(:date_from => '2013-01-01')
  end

  it "gets availability report" do
    @livechat.reports.availability
  end

  it "gets chatting time report" do
    @livechat.reports.chatting_time
  end

  it "gets goals report" do
    @livechat.reports.goals
  end

end

