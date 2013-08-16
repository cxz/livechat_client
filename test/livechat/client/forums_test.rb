require "test_helper"

describe Livechat::Client::Forums do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end

    @forum_id = ENV["LIVE"] ? @zendesk.forums[-1].id : 123
  end

  describe "GET" do
    it "should get all forums" do
      forums = @zendesk.forums.fetch
      refute_empty forums
    end

    it "should get a single forum by id" do
      forum = @zendesk.forums(@forum_id).fetch
      refute_nil forum
    end

    it "should get all entries for a forum" do
      entries = @zendesk.forums(@forum_id).entries.fetch
      refute_empty entries
    end
  end

  describe "POST" do
    it "should create a forum with a hash" do
      forum = @zendesk.forums.create({:name => "FAQ"})
      assert_equal "FAQ", forum.name
      @zendesk.forums(forum["id"]).delete
    end

    it "should create a forum with a block" do
      forum = @zendesk.forums.create do |forum|
        forum[:name] = "FAQ"
        forum[:description] = "All your Q's will be A'd"
      end
      assert_equal "FAQ", forum.name
      @zendesk.forums(forum["id"]).delete
    end
  end

  describe "PUT" do
    it "should update forum with a hash" do
      @zendesk.forums(@forum_id).update({:description => "bla"})
      forum = @zendesk.forums(@forum_id).fetch
      assert_equal "bla", forum.description
    end

    it "should update forum with a block" do
      forum = @zendesk.forums(@forum_id).update do |u|
        u[:description] = "yay"
      end
      assert_equal "yay", forum.description
    end
  end

  describe "DELETE" do
    it "should delete forum" do
      forum = @zendesk.forums.create({:name => "FAQ"})
      @zendesk.forums(forum["id"]).delete
      assert_raises(Livechat::NotFound) { @zendesk.forums(forum.id).fetch }
    end
  end
end
