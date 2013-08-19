require "spec_helper"

include WebMock::API


describe LiveChat::REST::Groups do
  before do
    @livechat = create_client

    stub_rest 'groups'
  end

  after do
    WebMock.reset!
  end


  it "lists all groups" do
    @livechat.groups
  end

  it "gets a single group details" do
    @livechat.groups(2)
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

