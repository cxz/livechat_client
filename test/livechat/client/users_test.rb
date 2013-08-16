require "test_helper"

describe Livechat::Client::Users do
  before do
    @zendesk = Livechat::Client.new do |config|
      config.account = ENDPOINT
      config.basic_auth EMAIL, PASSWORD
    end

    @user_id = ENV["LIVE"] ? @zendesk.users[-1].id : 123
  end

  describe "GET" do
    it "all users" do
      users = @zendesk.users.fetch
      refute_empty users
    end

    it "single user by id" do
      user = @zendesk.users(@user_id).fetch
      refute_nil user
    end

    it "currently authenticated user" do
      user = @zendesk.users.current.fetch
      refute_nil user
    end

    it "all users by query" do
      unless ENDPOINT =~ /localhost/ # search on localhost is a pain
        users = @zendesk.users("foo").fetch
        refute_empty users
      end
    end
  end

  describe "POST" do
    it "should create a user with a hash" do
      user = @zendesk.users.create({:name => "Wu Tang", :email => "wu@tang.net"})
      assert_equal "Wu Tang", @zendesk.users(user[:id]).fetch.name
      @zendesk.users(user[:id]).delete
    end

    it "should create a user with a block" do
      user = @zendesk.users.create do |user|
        user[:name] = "Wu Tang"
        user[:email] = "wu@tang.net"
      end
      assert_equal "Wu Tang", @zendesk.users(user[:id]).fetch.name
      @zendesk.users(user[:id]).delete
    end
  end

  describe "PUT" do
    it "should update user with a hash" do
      @zendesk.users(@user_id).update({:details => "yo"})
      user = @zendesk.users(@user_id).fetch
      assert_equal "yo", user.details
    end

    it "should update user with a block" do
      @zendesk.users(@user_id).update do |u|
        u[:details] = "nice guy"
      end
      user = @zendesk.users(@user_id).fetch
      assert_equal "nice guy", user.details
    end
  end

  describe "DELETE" do
    it "should delete user" do
      user = @zendesk.users.create({:name => "Hong Kong Phooey"})
      @zendesk.users(user[:id]).delete
      assert_raises(Livechat::NotFound) { @zendesk.users(user[:id]).fetch }
    end
  end
end
