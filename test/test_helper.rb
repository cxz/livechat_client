require "rubygems"
require "minitest/autorun"
require "webmock/minitest"
require "uri"
require "pry"
require "json"

$: << File.expand_path("../lib")
require "livechat"

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file).read.to_s
end

if ENV["LIVE"]
  LOGIN    = ENV["LIVECHAT_LOGIN"]
  API_KEY = ENV["LIVECHAT_API_KEY"]

else
  LOGIN, API_KEY = "ignored_login", "ignored_api_key"
  ENDPOINT = URI(LiveChat::Config::DEFAULT_ENDPOINT).host
end

