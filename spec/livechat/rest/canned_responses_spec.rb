require "spec_helper"

include WebMock::API


describe LiveChat::REST::CannedResponses do
  before do
    @livechat = create_client

    stub_rest 'canned_responses'
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

