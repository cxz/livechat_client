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

def stub_rest(resource_name)
  base = "#{ENDPOINT}/#{resource_name}"
  singular = resource_name.chop #todo inflect
  stub_request(:delete, /#{base}/)
  stub_request(:any, /#{base}/).to_return(:body => fixture("#{singular}.json"))
  stub_request(:get, "#{base}").to_return(:body => fixture("#{resource_name}.json"))
end

if ENV["LIVE"]
  LOGIN    = ENV["LIVECHAT_LOGIN"]
  API_KEY = ENV["LIVECHAT_API_KEY"]
else
  LOGIN, API_KEY = "ignored_login", "ignored_api_key"
  ENDPOINT = "https://#{LOGIN}:#{API_KEY}@ignored:443"
end

LiveChat::REST::Client::DEFAULTS[:host] = 'ignored'

def create_client
  LiveChat::REST::Client.new do |config|
    config[:login] = LOGIN
    config[:api_key] = API_KEY
  end
end
