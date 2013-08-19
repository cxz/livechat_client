$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'livechat'
require 'webmock/rspec'
require 'json'

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
  ENDPOINT = "https://#{LOGIN}:#{API_KEY}@ignored:443"
end

LiveChat::REST::Client::DEFAULTS[:host] = 'ignored'
