require "spec_helper"

include WebMock::API

describe LiveChat::REST::Agents do
  before do
    @livechat = create_client

    @john_id = 'john.doe@mycompany.com'
    @jane_id = 'jane.doe@mycompany.com'
    @alice_id = 'alice@mycompany.com'

    stub_rest 'agents'
  end

  after do
    WebMock.reset!
  end

  it "lists all agents" do
    agents = @livechat.agents.list
    expect(agents.length).to be(2)
  end

  it "gets a single agent details" do
    agent = @livechat.agents(@john_id)
    expect(agent.login).to eq(@john_id)
  end

  it "creates a new agent" do
    @livechat.agents.create do |a|
      a[:login] = @alice_id
      a[:name] = 'Alice'
    end
  end

  #all properties are optional
  it "updates an agent" do
    @livechat.agents(@jane_id).update do |a|
      a[:job_title] = 'Tester'
      a[:status] = 'not accepting chats'
    end
  end

  it "resets an API key" do
    @livechat.agents(@alice_id).reset_api_key
  end

  it "removes an agent" do
    @livechat.agents(@alice_id).delete
  end
end
