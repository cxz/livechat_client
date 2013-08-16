require "rubygems"
require "faraday"
require "json"
require "base64"

module Livechat
  class Connection
    def initialize(login, api_key)
      @lci = Faraday.new(:url => "https://api.livechatinc.com/") do |config|
        config.request :url_encoded
        config.request :json
        config.response :logger
        config.adapter :net_http
      end
      @lci.headers = {'X-API-Version' => '2'}
      @lci.basic_auth login, api_key
      @lci
    end

    # GET resources
    %w[ agents ].each do |resource|
      class_eval <<-METHOD
        def #{resource}
          #{resource} = @lci.get("#{resource}")
          JSON.parse(#{resource}.body)
        end
      METHOD
    end

    # delegate to faraday
    def method_missing(method, *args, &block)
      @lci.send(method, *args, &block)
    end
  end
end
