require "spec_helper"

include WebMock::API


describe LiveChat::REST::Goals do
  before do
    @livechat = create_client

    stub_rest 'goals'
  end

  after do
    WebMock.reset!
  end


  it "lists all goals" do
    @livechat.goals
  end

  it "gets a single goal details" do
    @livechat.goals(1181)
  end

  it "marks goal as successful" do
    @livechat.goals(1181).mark_as_successful(:visitor_id => 1, :order_id => 'AP723HVCA721')
    expect(@livechat.last_request.body).to eq 'visitor_id=1&order_id=AP723HVCA721'

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

