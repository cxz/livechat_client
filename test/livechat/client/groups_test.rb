require "test_helper"

describe Livechat::Client::Groups do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end

    @group_id = ENV["LIVE"] ? @zendesk.groups[-1].id : 123
  end

  describe "GET" do
    it "all groups" do
      groups = @zendesk.groups.fetch
      refute_empty groups
    end

    it "single group by id" do
      group = @zendesk.groups(@group_id).fetch
      refute_nil group
    end
  end

  describe "POST" do
    it "should create a group with a hash" do
      group = @zendesk.groups.create({:name => "Wu Tang Clan"})
      assert_equal "Wu Tang Clan", group.name
      @zendesk.groups(group.id).delete
    end

    it "should create a group with a block" do
      group = @zendesk.groups.create do |group|
        group[:name] = "Wu Tang Clan"
      end
      assert_equal "Wu Tang Clan", group.name
      @zendesk.groups(group.id).delete
    end
  end

  describe "PUT" do
    it "should update group with a hash" do
      @zendesk.groups(@group_id).update({:name => "Souls of Mischief"})
      group = @zendesk.groups(@group_id).fetch
      assert_equal "Souls of Mischief", group.name
    end

    it "should update group with a block" do
      group = @zendesk.groups(@group_id).update do |u|
        u[:name] = "Madvillian"
      end
      assert_equal "Madvillian", group.name
    end
  end

  describe "DELETE" do
    it "should delete group" do
      group = @zendesk.groups.create({:name => "Visionaries"})
      @zendesk.groups(group.id).delete
      assert_raises(Livechat::NotFound) { @zendesk.groups(group.id).fetch }
    end
  end
end
