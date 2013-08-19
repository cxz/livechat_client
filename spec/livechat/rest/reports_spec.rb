require "spec_helper"

include WebMock::API


describe LiveChat::REST::Reports do
  before do
    @livechat = create_client
    @reports_base = "#{ENDPOINT}/reports"
    stub_request(:get, /#{@reports_base}/).to_return(:body => {})
  end

  after do
    WebMock.reset!
  end

  it "gets dashboard data" do
    @livechat.reports.dashboard
    expect(@livechat.last_request.path).to eq '/reports/dashboard'
  end

  it "gets dashboard data for agent" do
    @livechat.reports.dashboard(:agent => 'john.doe@mycompany.com')
  end

  it "gets dashboard data for group" do
    @livechat.reports.dashboard(:group => 1)
    expect(@livechat.last_request.path).to eq '/reports/dashboard/group/1'
  end

  it "gets chats report" do
    @livechat.reports.chats(:date_from => '2013-01-01')
    expect(@livechat.last_request.path).to eq '/reports/chats?date_from=2013-01-01'
  end

  it "gets ratings report" do
    @livechat.reports.ratings(:group => 1)
    expect(@livechat.last_request.path).to eq '/reports/ratings?group=1'
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
    expect(@livechat.last_request.path).to eq '/reports/goals'
  end

end

