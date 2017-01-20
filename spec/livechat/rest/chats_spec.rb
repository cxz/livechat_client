require "spec_helper"

include WebMock::API

describe LiveChat::REST::Chats do
  before do
    @livechat = create_client

    stub_rest 'chats'
  end

  after do
    WebMock.reset!
  end

  it "gets list of chats" do
    chats = @livechat.chats
    expect(chats.list.length).to be(1)
  end

  it "gets single chat" do
    chat = @livechat.chats('MH022RD0K5')
    expect(chat.visitor_name).to eq('Mary Brown')
  end

  it "sends chat transcript to e-mail" do
    @livechat.chats('MH022RD0K5').send_transcript(:to => 'john.doe@mycompany.com')
    expect(@livechat.last_request.path).to eq '/chats/MH022RD0K5/send_transcript'
    expect(@livechat.last_request.method).to eq 'POST'
    expect(@livechat.last_request.body).to eq '{"to":"john.doe@mycompany.com"}'
  end
end

