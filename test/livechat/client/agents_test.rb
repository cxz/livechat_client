require "test_helper"

include WebMock::API


describe LiveChat::Client::Agents do

  before do
    @livechat = LiveChat::Client.new do |config|
      config.login = LOGIN
      config.api_key = API_KEY
    end

    @john_id = 'john.doe@mycompany.com'
    @jane_id = 'jane.doe@mycompany.com'
    @alice_id = 'alice@mycompany.com'

    stub_request(:get, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents").
        to_return(:body => JSON.parse(fixture('agents.json')))

    stub_request(:get, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents/#{@john_id}").
        to_return(:body => JSON.parse(fixture('john_doe.json')))

    stub_request(:post, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents")

    stub_request(:put, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents/#{@jane_id}")

    stub_request(:delete, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents")

    stub_request(:put, "https://#{LOGIN}:#{API_KEY}@#{ENDPOINT}/agents/reset_api_key")

  end

  after do
    WebMock.reset!
  end

  it "List all agents" do
    agents = @livechat.agents.fetch
    assert agents
    assert_equal 2, agents.length
  end

  it "Get a single agent details" do
    agent = @livechat.agents(@john_id).fetch
    assert_equal @john_id, agent['login']
  end

  #required
  #  login
  #  name
  #optional
  #  job_title – defaults to: Support Agent.
  #  login_status - possible values: accepting chats (default), not accepting chats.
  #  permission – administrator, normal (default).
  #  groups[] – list of group IDs.
  #  notifications – object (allowed keys: new_visitor, returning_visitor, queued_visitor, visitor_is_typing, new_goal, allowed values: 0 or 1).
  #  daily_summary – 0 or 1 (default).
  #  max_chats_count – defaults to 6.
  it "Create a new agent" do
    agent = @livechat.agents.create do |a|
      a[:login] = @alice_id
      a[:name] = 'Alice'
    end
  end

  #all properties are optional
  it "Update an agent" do
    @livechat.agents(@jane_id).update do |a|
      a[:job_title] = 'Tester'
      a[:status] = 'not accepting chats'
    end
  end

  it "Reset an API key" do
    @livechat.agents(@agent_id).reset_api_key
  end

  it "Remove an agent" do
    @livechat.agents(@agent_id).delete
  end

end
