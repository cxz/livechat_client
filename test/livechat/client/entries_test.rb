require "test_helper"

describe Livechat::Client::Entries do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end

    @entry_id = ENV["LIVE"] ? @zendesk.entries[-1].id : 123
    @forum_id = ENV["LIVE"] ? @zendesk.forums[-1].id : 123
  end

  describe "GET" do
    it "should get all entries" do
      refute_empty @zendesk.entries.fetch
    end

    it "should get a single entry by id" do
      refute_nil @zendesk.entries(@entry_id).fetch
    end
  end

  describe "POST" do
    it "should create an entry with a hash" do
      entry = @zendesk.entries.create({:title => "What would you do with a brain if you had one?", :forum_id => @forum_id, :body => "yo"})
      assert_equal "What would you do with a brain if you had one?", entry.title
      @zendesk.entries(entry[:id]).delete
    end

    it "should create an entry with a block" do
      entry = @zendesk.entries.create do |entry|
        entry[:forum_id] = @forum_id
        entry[:title]    = "FAQ"
        entry[:body]     = "All your Q's will be A'd"
      end
      assert_equal "FAQ", entry.title
      @zendesk.entries(entry[:id]).delete
    end
  end

  describe "PUT" do
    it "should update entry with a hash" do
      @zendesk.entries(@entry_id).update({:body => "bla bla bla"})
      entry = @zendesk.entries(@entry_id).fetch
      assert_equal "bla bla bla", entry.body
    end

    it "should update entry with a block" do
      entry = @zendesk.entries(@entry_id).update do |entry|
        entry[:additional_tags] = "yay"
      end
      assert_includes entry.current_tags, "yay"
    end
  end

  describe "DELETE" do
    it "should delete entry" do
      entry = @zendesk.entries.create({:title => "FAQ", :body => "yo", :forum_id => @forum_id})
      @zendesk.entries(entry[:id]).delete
      assert_raises(Livechat::NotFound) { @zendesk.entries(entry[:id]).fetch }
    end
  end
end
