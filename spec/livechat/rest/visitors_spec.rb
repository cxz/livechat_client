require "spec_helper"

include WebMock::API


describe LiveChat::REST::Visitors do
  before do
    @livechat = create_client

    stub_rest 'visitors'
  end

  after do
    WebMock.reset!
  end


  it "lists all visitors" do
    @livechat.visitors.fetch
  end

  it "lists only chatting visitors" do
    @livechat.visitors.chatting
  end

  it "adds custom visitor details" do
    @livechat.visitors('S1352647457.ac951bfe2e').add_details do |detail|
      detail[:license_id] = '12345'
      detail[:token] = '26132406c42c96ba61ed42689b70f719'
      detail[:id] = 'my-app'
      #todo: need to test array encoding for the fields parameter. example:
      #curl -H X-API-Version:2 https://api.livechatinc.com/visitors/S1352647457.ac951bfe2e/details -X POST
      #-d "license_id=12345&token=26132406c42c96ba61ed42689b70f719&id=my-app&fields[0][name]=Age&fields[0][value]=36"
      detail[:fields] = [{:name => 'Age', :value => 36}]
    end
  end

end

